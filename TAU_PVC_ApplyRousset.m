function roigroups=TAU_PVC_ApplyRousset(apet,aaparc,roigroups,scannersmooth)

% Applies Rousset method of partial volume correction to PET data.  This
% particular script relies on ROIs solely derived from the Freesurfer
% segmentation.  If you want to add ROIs that aren't part of the freesurfer
% segmentation or use a bunch of ROI masks, this won't work.  See Suzanne.
%
% apet : full filename path to pet data.  can be multiple frames of PET data 
%           that are coregistered to the nu.nii that belongs to the aparc+aseg.nii
%
% aaparc : full filename path to aparc+aseg.nii from Freesurfer segmentation.
%
% roigroups : variable that lists the ROIs used in the analysis 
%
% scannersmooth : variable representing x, y and z resolutions of the
%           scanner.
%
% Citation: Rousset OG, Ma Y, Evans AC. Correction for partial volume
%               effects in PET: principle and validation. J Nucle Med. 
%               1998; 39:904-11.



[fa fb fc]=fileparts(apet(1,:));
if isempty(fa)
    fa=pwd;
end
Vpet=spm_vol(apet);
pet=spm_read_vols(Vpet);
Vaparc=spm_vol(aaparc);
aparc=spm_read_vols(Vaparc);
[sz1 sz2 sz3 sz4]=size(pet);
[ssz1 ssz2 ssz3]=size(aparc);
numrois=size(roigroups,2);
voxsmooth(1)=scannersmooth(1)./abs(Vpet.mat(1,1));
voxsmooth(2)=scannersmooth(2)./abs(Vpet.mat(2,2));
voxsmooth(3)=scannersmooth(3)./abs(Vpet.mat(3,3));

if sz1==ssz1 & ssz2==sz2 & sz3==ssz3
    rpet=reshape(pet,sz1*sz2*sz3,sz4);
    raparc=reshape(aparc,sz1*sz2*sz3,1);
    disp(['smoothing'])
   for i=1:numrois
        %disp(['smoothing ... ' num2str(i) '/' num2str(numrois)])
        ind=[];
        for j=1:size(roigroups{i}.ind,2)
            tmp=find(raparc==roigroups{i}.ind(j));
            ind=[ind; tmp];
        end
        rroi=zeros(sz1*sz2*sz3,1);
        rroi(ind)=ones(size(ind,1),size(ind,2));
        roi=reshape(rroi,sz1,sz2,sz3);
        smoothroi=zeros(sz1,sz2,sz3);
        
        spm_smooth(roi,smoothroi,voxsmooth);
        y(:,:,:,i)=roi;
        ys(:,:,:,i)=smoothroi;
    end
    chdir(fa)
    ry=reshape(y,sz1*sz2*sz3,numrois);
    rys=reshape(ys,sz1*sz2*sz3,numrois);
    if sz4>1
        prodrpet=prod(rpet')';
    else
        prodrpet=rpet;
    end
    disp(['Calculating'])
    for i=1:numrois
        %disp(['calculating ... ' num2str(i) '/' num2str(numrois)])
        for j=1:numrois
            ind=find(ry(:,i)>0.5);
            percinroi(i,j)=mean(rys(ind,j));
            ind=find(ry(:,i)>0.5 & prodrpet>0);
            meanroi(i,:)=mean(rpet(ind,:),1);
            
        end
    end
    for i=1:sz4
        pvcroi(i,:)=percinroi\meanroi(:,i);
    end
    for i=1:numrois
        roigroups{i}.nonpvcval=meanroi(i,:);
        roigroups{i}.pvcval=pvcroi(:,i)';
        roigroups{i}.percinroi=percinroi(i,:);
    end
    chdir(fa);
else
    disp(['aparc+aseg and pet are not the same size... cannot run PVC'])
end