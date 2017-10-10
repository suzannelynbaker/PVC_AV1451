function []=TAUPVC_RUNME_Create_ROIs_For_Rousset(fname_aparc,fname_suvr,fname_c1,fname_c2,fname_c3,fname_c4,fname_c5,fname_cere,scanner_resolution)
                        
%  This function creates a file where each ROI has a different integer value.
%  All image files should have the same matrix size and should be coregistered
%  and resliced to each other.  Inputs are:
%      fname_aparc: the path to the aparc+aseg.nii output from
%                       freesurfer
%      fname_suvr: the path to the mean av-1451 file.  this does not
%                       have to be normalized, but data will be normalized
%                       by inferior cerebellar gray and written out; 
%                       extra-cortical-hotspot threshold is in reference to
%                       image normalized by inferior cerebellar gray  
%       fname_c1: output from nu.nii segmented by spm12
%       fname_c2: output from nu.nii segmented by spm12
%       fname_c3: output from nu.nii segmented by spm12
%       fname_c4: output from nu.nii segmented by spm12
%       fname_c5: output from nu.nii segmented by spm12
%       fname_cere: path to reverse normalize and resliced
%                       SUIT cerebellar gray template to nu.nii
%       scanner_resolution: example [6.5 6.5 7.5].  we calculated this
%                       for our scanner using a Hoffman phantom (method used in 
%                       Joshi, Koeppe, Fessler from Neuroimage, 2009)

% Load files and check matrix sizes
%       1: aparc       5: c3
%       2: suvr        6: c4
%       3: c1          7: c5
%       4: c2          8: cere
img=TAU_PVC_LoadFiles(fname_aparc,fname_suvr,fname_c1,fname_c2,fname_c3,fname_c4,fname_c5,fname_cere);

% assign integer values to aparc+aseg defined ROIs
aparc=img{1}.data;
suvr=img{2}.data;
[sz1 sz2 sz3]=size(aparc);
raparc=reshape(aparc,sz1*sz2*sz3,1);
rsuvr=reshape(suvr,sz1*sz2*sz3,1);
[rnewaparc roigroups]=TAU_PVC_AssignFreeSurferROIs(raparc,rsuvr);

% use SUIT cerebellar template reverse normalized to nu.nii to calculate
% inferior cerebellar gray, add that to rnewaparc such that 
% inferior cerebellar gray voxels = 78
cere=img{8}.data;
[rnewaparc suvr]=TAU_PVC_AddInferiorCereg_FromSUIT(cere,suvr,rnewaparc);
roigroups{78}.name=['inferior_cerebellar_gray']; roigroups{78}.ind=78;

% use freesurfer aparc+aseg choroid and suvr to split choroid into high and
% low values
rnewaparc=TAU_PVC_AddChoroid(suvr,aparc,rnewaparc);
roigroups{79}.name=['high_choroid_plexus']; roigroups{79}.ind=79;
roigroups{80}.name=['low_choroid_plexus']; roigroups{80}.ind=80;


c3=img{5}.data;     c4=img{6}.data;     c5=img{7}.data;     aparc=img{1}.data;
ECHclusters=TAU_PVC_FindECHs(c3,c4,c5,suvr,aparc,scanner_resolution);

% add ECH clusters to new aparc, these count up starting from 83, each ECH
% gets its own integer value
rECHclusters=reshape(ECHclusters,sz1*sz2*sz3,1);
ind=find(rECHclusters>0);
uech=unique(rECHclusters(ind));
for j=1:length(uech)
    ind=find(raparc==0 & rECHclusters==uech(j));
    rnewaparc(ind)=(84+j);
    roigroups{84+j}.name=['ECH_' num2str(j)]; roigroups{84+j}.ind=84+j;
end

% add c3 low (81) and high (82) and c4+c5 low (83) and high (84).  
% look for voxels=0 in aparc+aseg but are right next to brain ROIs, assign
% to ROIs
c1=img{3}.data;
rnewaparc=TAU_PVC_assign_c3c4c5_randoms(c1,c3,c4,c5,suvr,rnewaparc);
roigroups{81}.name=['c3_low']; roigroups{81}.ind=81;
roigroups{82}.name=['c3_high']; roigroups{82}.ind=82;
roigroups{83}.name=['c4+c5_low']; roigroups{83}.ind=83;
roigroups{84}.name=['c4+c5_high']; roigroups{84}.ind=84;

% check for ECHs in cerebellar gray.  these count up from the current highest value
% in the new aparc+aseg (rnewaparc) which reflects who many ECHs there were
% in c3/c4/c5 (so if 2 ECHs in c3/c4/c5, those were assigned 83 and 84, if
% 3 ECHs are found in inferior cerebellar gray, those would be 85, 86, 87)
[rnewaparc suvr roigroups]=TAU_PVC_CheckInfCereg_for_hotspots(rnewaparc,suvr,roigroups);

% set ventricles (9999 from TAU_PVC_AssignFreesurferROIs) to 0
ind=find(rnewaparc==9999);
rnewaparc(ind)=zeros(length(ind),1);

% done, reshape, write out new suvr (normalized by inf cerebellar gray)
% and ROIs for Rousset PVC in the directory where the original SUVR lives
newaparc=reshape(rnewaparc,sz1,sz2,sz3);
[fa fb fc]=fileparts(fname_suvr);
Vsuvr=img{2}.V;
Vsuvr.fname=[fa '/FINAL0_suvr_normalized_infcereg.nii'];
spm_write_vol(Vsuvr,suvr);
Vaparc=img{1}.V;
Vaparc.fname=[fa '/FINAL0_edited_aparc+aseg.nii'];
spm_write_vol(Vaparc,newaparc);

% Run Rousset PVC, save results in roigroups.mat as variable roigroups
roigroups=TAU_PVC_CheckROIgroups_for_PVC(rnewaparc,roigroups);
roigroups=TAU_PVC_ApplyRousset(Vsuvr.fname,Vaparc.fname,roigroups,scanner_resolution);
chdir(fa)
save FINAL0_roigroups roigroups