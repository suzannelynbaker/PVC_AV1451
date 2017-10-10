function rnewaparc=TAU_PVC_AddChoroid(suvr,aparc,rnewaparc)

% Separate Choroid into high and low regions (by 1) but keeping voxels
% contiguous as much as possible:
% 1. make low mask (<1) and high mask (>1) for choroid
% 2. send each through FindCluster
% 3. any clusters with >100 voxels stay in respective ROI
% 4. smooth those low and high clusters ROIs  (with >100 voxels) by 8mm3 (call this smoothlow and smoothhigh)
% 5. any voxels in aparc+aseg choroid where smoothlow>smoothhigh is assigned to finallow ROI, and smoothhigh>smoothlow is assigned to finalhigh ROI
% 6. any choroid voxels that weren't assigned in 5 (and therefore not near a cluster of choroid voxels) then just gets assigned to low if its suvr<1 and high if suvr>1

% make original aparc and suvr 1d
[sz1 sz2 sz3]=size(aparc);
raparc=reshape(aparc,sz1*sz2*sz3,1);
rsuvr=reshape(suvr,sz1*sz2*sz3,1);

% search high choroid voxels >1
ind=find((raparc==31 | raparc==63) & rsuvr>1);
rmask=zeros(sz1*sz2*sz3,1);
rmask(ind)=ones(length(ind),1);
highmask=reshape(rmask,sz1,sz2,sz3);
%find high clusters
highclusters=TAU_PVC_FindClusters(highmask);
rhighclusters=reshape(highclusters,sz1*sz2*sz3,1);
ind=find(rhighclusters>0);
% how many high clusters are there
uhighclusters=unique(rhighclusters(ind));
rhighbig=zeros(sz1*sz2*sz3,1);
for i=1:length(uhighclusters)
    ind=find(rhighclusters==uhighclusters(i));
    % keep as high choroid cluster only if there are > 100 voxels in a cluster
    if length(ind)>100
        rhighbig(ind)=ones(length(ind),1);
    end
end

% search low choroid voxels <=1
ind=find((raparc==31 | raparc==63) & rsuvr<=1);
rmask=zeros(sz1*sz2*sz3,1);
rmask(ind)=ones(length(ind),1);
lowmask=reshape(rmask,sz1,sz2,sz3);
%find low clusters
lowclusters=TAU_PVC_FindClusters(lowmask);
rlowclusters=reshape(lowclusters,sz1*sz2*sz3,1);
ind=find(rlowclusters>0);
% how many low clusters are there
ulowclusters=unique(rlowclusters(ind));
rlowbig=zeros(sz1*sz2*sz3,1);
for i=1:length(ulowclusters)
    ind=find(rlowclusters==ulowclusters(i));
    % keep as a low choroid cluster if there are > 100 voxels
    if length(ind)>100
        rlowbig(ind)=ones(length(ind),1);
    end
end

highbig=reshape(rhighbig,sz1,sz2,sz3);
lowbig=reshape(rlowbig,sz1,sz2,sz3);
shighbig=zeros(sz1,sz2,sz3);
slowbig=zeros(sz1,sz2,sz3);
%smooth high and low clusters
spm_smooth(highbig,shighbig,[8 8 8]);
spm_smooth(lowbig,slowbig,[8 8 8]);

rshighbig=reshape(shighbig,sz1*sz2*sz3,1);
rslowbig=reshape(slowbig,sz1*sz2*sz3,1);

% voxels for which smoothed high > smoothed low --> high (and vice versa)
% this includes voxels that had clusters of <= 100 voxels
rhighfinal=zeros(sz1*sz2*sz3,1);
rlowfinal=zeros(sz1*sz2*sz3,1);
% 79: high choroid
ind=find(rshighbig>rslowbig & (raparc==31 | raparc==63));
rnewaparc(ind)=79.*ones(length(ind),1);
% 80: low choroid
ind=find(rshighbig<rslowbig & (raparc==31 | raparc==63));
rnewaparc(ind)=80.*ones(length(ind),1);


%remaining voxels who not assigned yet simply assigned by their suvr 
% 79: high choroid
ind=find(rsuvr>1 & (raparc==31 | raparc==63) & rnewaparc==0);
rnewaparc(ind)=79.*ones(length(ind),1);
% 80: low choroid
ind=find(rsuvr<=1 & (raparc==31 | raparc==63) & rnewaparc==0);
rnewaparc(ind)=80.*ones(length(ind),1);


