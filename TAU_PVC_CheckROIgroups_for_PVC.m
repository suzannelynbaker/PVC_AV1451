function [roigroups]=TAU_PVC_CheckROIgroups_for_PVC(rnewaparc,roigroups);

oldroi=roigroups;
clear roigroups

cnt=0;
for i=1:length(oldroi);
    ind=find(rnewaparc==oldroi{i}.ind);
    if length(ind)>0
        cnt=cnt+1;
        roigroups{cnt}=oldroi{i};
    end
end