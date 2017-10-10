function ECHclusters=TAU_PVC_FindECHs(c3,c4,c5,suvr,aparc,resol)

%% Thresholds
minClust=500;  
minC45=0.3;
minSUVR=1.6;



[sz1 sz2 sz3]=size(aparc);
raparc=reshape(aparc,sz1*sz2*sz3,1);

% create brainmask as voxels > 0 in aparc+aseg freesurfer segmentation
ind=find(raparc>0);
rbrainmask=zeros(sz1*sz2*sz3,1);
rbrainmask(ind)=ones(length(ind),1);
brainmask=reshape(rbrainmask,sz1,sz2,sz3);

% smooth voxels in brainmask, smooth voxels where c4+c5>=0.5
c45=c4+c5;
sbrainmask=zeros(sz1,sz2,sz3);
sc45=zeros(sz1,sz2,sz3);
spm_smooth(round(c45),sc45,resol);
spm_smooth(brainmask,sbrainmask,resol);

% reshaping
rsc45=reshape(sc45,sz1*sz2*sz3,1);
rc3=reshape(c3,sz1*sz2*sz3,1);
rsbrainmask=reshape(sbrainmask,sz1*sz2*sz3,1);

% trying to include some of c3 that is closer to c4+c5 than it is to brain
% find voxels that have higher than 50% probability of being c3 and where
% smoothed c4+c5 > smoothed brainmask.  save as newc3 mask
ind=find(rc3>0.5 & rsc45>rsbrainmask);
rnewc3=zeros(sz1*sz3*sz3,1);
rnewc3(ind)=ones(length(ind),1);
newc3=reshape(rnewc3,sz1,sz2,sz3);


% reshaping
rc45=reshape(c45,sz1*sz2*sz3,1);
rsuvr=reshape(suvr,sz1*sz2*sz3,1);

%search for possible ECHs.  looking for voxels where both 1 and 2 are satisfied:
%   1. c4+c5 > minC45 threshold -or- the new c3 mask (that is closer to
%       c4+c5 than to brain) has threshold >0.5
%   2. SUVR is above a certain threshold.  we started with 1.3 and found
%       that to be too low, so we increased to 1.6
ind=find((rc45>minC45 | rnewc3>.5) & rsuvr>minSUVR);
rmask=zeros(sz1*sz2*sz3,1);
rmask(ind)=ones(length(ind),1);
mask=reshape(rmask,sz1,sz2,sz3);

% divide the mask created above into contiguous clusters
mask2=TAU_PVC_FindClusters(mask);
rmask2=reshape(mask2,sz1*sz2*sz3,1);
umask2=unique(rmask2);
ind=find(umask2>0);
uumask2=umask2(ind);
cnt=0;
rnew=zeros(sz1*sz2*sz3,1);
for i=1:length(uumask2)
    ind=find(rmask2==uumask2(i));
    if length(ind)>minClust
        cnt=cnt+1;
        rnew(ind)=cnt.*ones(length(ind),1);
    end
end
ECHclusters=reshape(rnew,sz1,sz2,sz3);