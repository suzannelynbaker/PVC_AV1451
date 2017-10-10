function [rnewaparc]=TAU_PVC_assign_c3c4c5_randoms_nohighlow(c1,c3,c4,c5,suvr,rnewaparc);

[sz1 sz2 sz3]=size(suvr);
rsuvr=reshape(suvr,sz1*sz2*sz3,1);
c45=c4+c5;
rc1=reshape(c1,sz1*sz2*sz3,1);
rc3=reshape(c3,sz1*sz2*sz3,1);
rc45=reshape(c45,sz1*sz2*sz3,1);

%c3: high & low + c1 voxels not assigned yet that might be c3
ind=find(rnewaparc==0 & (rc3>0.3 | rc1 >0.3) & rc3>rc45   & rsuvr>0.1  & rsuvr<1); 
rnewaparc(ind)=81; %c3low
ind=find(rnewaparc==0 & (rc3>0.3 | rc1 >0.3) & rc3>rc45  & rsuvr>=1);
rnewaparc(ind)=82; %c3high

%c4/5: high and low and c1 voxels not assigned yet that might be c45
ind=find(rnewaparc==0 & (rc45>0.3 | rc1 >0.3) & rc45>rc3 & rsuvr<1 & rsuvr>0.1); 
rnewaparc(ind)=83;%c45low
ind=find(rnewaparc==0 & (rc45>0.3 | rc1 >0.3) & rc45>rc3 & rsuvr>=1);
rnewaparc(ind)=84;%c45high

%% c1 voxels with 0 prob. to be c3 or c45 (not assigned yet)
ind =find(rc1> 0.3 & rc3 == 0 & rc45==0  & rsuvr>0.1  & rnewaparc==0);
rnewaparc(ind)=7005;%c1 leftover voxels
aparc=reshape(rnewaparc,sz1,sz2,sz3);
% for random zeros in the new aparc+aseg in the brain area, it looks to see
% what is around those voxels and assigns them to whichever ROI takes up
% most of neighboring voxels
dd=[1 0 0; 0 1 0; 0 0 1; -1 0 0; 0 -1 0; 0 0 -1; ...
    1 1 1; 1 1 -1; 1 -1 1; -1 1 1; 1 -1 -1; -1 1 -1; -1 -1 1; -1 -1 -1; ...
    1 1 0; 1 0 1; 0 1 1; -1 -1 0; -1 0 -1; 0 -1 -1; ...
    1 -1 0; -1 1 0; 1 0 -1; -1 0 1; 0 1 -1; 0 -1 1];

count=0;
while length(ind)>0
    for i=1:sz3 %going through slices
        [ix iy]=find(squeeze(aparc(:,:,i)==7005));
        for j=1:length(ix)
            t1=ix(j); t2=iy(j); t3=i; %going through voxels
            cnt=0;
            for k=1:size(dd,3)
                if aparc(t1+dd(k,1),t2+dd(k,2),t3+dd(k,3))~=7005 %neighbour voxels
                    cnt=cnt+1;
                    val(cnt)=aparc(t1+dd(k,1),t2+dd(k,2),t3+dd(k,3)); %aparc+aseg value
                end
            end
            if exist('val')
                count=count+1;
                NewValues(count)=val; %to see what it is assigned to
                aparc(t1,t2,t3)=mode(val);clear val; %mode =most frequent value in a sample.
            end
        end
    end
    % look again for voxels that were assigned 7005, keep running if find
    % "7005" voxels
    rnewaparc=reshape(aparc,sz1*sz2*sz3,1); ind=find(rnewaparc==7005);
end
