function [rnewaparc suvr]=TAU_PVC_AddInferiorCereg_FromSUIT(cere,suvr,rnewaparc)

[sz1 sz2 sz3]=size(cere);
rcere=reshape(cere,sz1*sz2*sz3,1);
rsuvr=reshape(suvr,sz1*sz2*sz3,1);
% find voxels we want to keep and toss in reverse-normalized cerebellum
% atlas
indkeep=find(rcere==6 | (rcere>=8 & rcere<=28) | rcere==33 | rcere==34);
indtoss=find(rcere<=5 | rcere==7);
rkeep=zeros(sz1*sz2*sz3,1);
rtoss=zeros(sz1*sz2*sz3,1);
% create binary masks for voxels we want to keep or toss
rkeep(indkeep)=ones(length(indkeep),1);
rtoss(indtoss)=ones(length(indtoss),1);
keep=reshape(rkeep,sz1,sz2,sz3);
toss=reshape(rtoss,sz1,sz2,sz3);
skeep=zeros(sz1,sz2,sz3);
stoss=zeros(sz1,sz2,sz3);
% smooth the binary masks for voxels we want to keep or toss, doing this bc
% there is not perfect overlap bw freesurfer's gray matter segmentation of
% cerebellum and the reversenormalized mask, so want a freesurfer gray
% matter voxel to be characterized in keep or toss group depending on how
% close it is to keep or toss regions in reverse normalized cerebellum
% template, even if it isn't defined as part of cerebellum in the template
spm_smooth(keep,skeep,[8 8 8]);
spm_smooth(toss,stoss,[8 8 8]);
rskeep=reshape(skeep,sz1*sz2*sz3,1);
rstoss=reshape(stoss,sz1*sz2*sz3,1);
% 78: inferior cerebellar gray
ind=find(rnewaparc==77 & rsuvr>0 & rskeep>rstoss);
rnewaparc(ind)=78.*ones(length(ind),1);
% normalize suvr to inferior cerebellar gray, this should be used for rest
% of time
mean_infcereg=mean(rsuvr(ind));
suvr=suvr./mean_infcereg;