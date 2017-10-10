function [rnewaparc suvr roigroups]=TAU_PVC_CheckInfCereg_for_ECHs(rnewaparc,suvr,roigroups);

minSUVR=1.6; minClust=500;
[sz1 sz2 sz3]=size(suvr);
rsuvr=reshape(suvr,sz1*sz2*sz3,1);

indinfcereg=find(rnewaparc==78);

cereg_mean(1)=mean(rsuvr(indinfcereg));
suvr=suvr./cereg_mean(1);%re-divide by cereg which should be 1 but just in case

%% Voxels with joint prob. > 0.3 and SUVR >1.3 
ind=find( rsuvr>=minSUVR & rnewaparc==78);
rmask=zeros(sz1*sz2*sz3,1);
rmask(ind)=ones(length(ind),1);
mask=reshape(rmask,sz1,sz2,sz3);

%% Find ECH clusters within mask
mask2=TAU_PVC_FindClusters(mask);
% goes through all the voxels in the matrix, if the voxel is 0, it ignores it. 
%as soon as it finds a voxels that is 1, it checks to see if another other voxels around it =1, if it is,
%it assigns it to the same cluster as the initiating voxels. 
%(the neighboring voxels it checks are just 6 that share faces with the voxel). 
%it keeps checking the surrounding voxels until they are all 0. 
%it then identifies that as cluster10 (second one is cluster20, i don't know why i counted by 10s, but it doesn't matter),
%so it won't check any more voxels in that cluster.  so then once i have a mask that has 10s, 20s, 30s, 40s, 50s, etc 
%(for however many non-touching clusters there are), i can check to see how many voxels are in the cluster (must be at least 500, no reason behind that). 

rmask2=reshape(mask2,sz1*sz2*sz3,1);
ind=find(rmask2>0);
uumask2=unique(rmask2(ind));% ex. 10,20,30,40, ...
cnt=0;
rinfcereECH=zeros(sz1*sz2*sz3,1);
for i=1:length(uumask2)
    ind=find(rmask2==uumask2(i));%find 10, 20, 30 etc
    if length(ind)>minClust     
        cnt=cnt+1;
        rinfcereECH(ind)=cnt.*ones(length(ind),1);% set the voxels in cluster to 1, 2, 3, 4 etc
    end
end
% IF ECHs in inferior cerebellar gray, create new values in 
% aparc+aseg for ECHs in inferior cerebellar gray
if cnt>0
    maxaparc=max(rnewaparc);
    maxroigroups=length(roigroups);
    ind=find(rinfcereECH>0);
    uhot=unique(rinfcereECH(ind));
    for j=1:length(uhot)
        ind=find(rinfcereECH==uhot(j));
        rnewaparc(ind)=(maxaparc+j);
        roigroups{maxroigroups+j}.name=['inf_cereg_hot_' num2str(j)]; roigroups{maxroigroups+j}.ind=maxaparc+j;
    end
    indclean=find(rnewaparc==78 & rsuvr>0.01);
    cereg_mean(2)=mean(rsuvr(indclean));
    % re-normalize SUVR to inferior cerebellar gray without ECHs
    suvr=suvr./cereg_mean(2);
end