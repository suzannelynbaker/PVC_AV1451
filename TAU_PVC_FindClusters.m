function [mask]=TAU_PVC_FindClusters(mask);

[sz1 sz2 sz3]=size(mask);
cnt=0;
d=[1 0 0;-1 0 0;0 1 0;0 -1 0; 0 0 1; 0 0 -1];
for i=1:sz1
    for j=1:sz2
        for k=1:sz3
            if mask(i,j,k)>0.9 & mask(i,j,k)<1.1
                cnt=cnt+10;
                mask(i,j,k)=cnt;
                spread=0;
                newvox=[i j k];
                while exist('newvox')
                    nvcnt=0;
                    for m=1:size(newvox,1)
                        for l=1:size(d,1);
                            if (newvox(m,1)+d(l,1)>0 & newvox(m,1)+d(l,1)<=sz2) & ...
                                    (newvox(m,2)+d(l,2)>0 & newvox(m,2)+d(l,2)<=sz2) & ...
                                    (newvox(m,3)+d(l,3)>0 & newvox(m,3)+d(l,3)<=sz3)
                                if mask(newvox(m,1)+d(l,1),newvox(m,2)+d(l,2),newvox(m,3)+d(l,3))>0.9 ...
                                     & mask(newvox(m,1)+d(l,1),newvox(m,2)+d(l,2),newvox(m,3)+d(l,3))<1.1
                                    nvcnt=nvcnt+1;
                                    newnew(nvcnt,:)=[newvox(m,1)+d(l,1),newvox(m,2)+d(l,2),newvox(m,3)+d(l,3)];
                                    mask(newvox(m,1)+d(l,1),newvox(m,2)+d(l,2),newvox(m,3)+d(l,3))=cnt;
                                end
                            end
                        end
                    end
                    clear newvox
                    if exist('newnew')
                        newvox=newnew;
                        clear newnew;
                    end
                end
            end
        end
    end
end
