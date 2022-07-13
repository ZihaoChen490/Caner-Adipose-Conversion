
%
clear
clc
addpath('C:\Aczh work place\2_paper\code_C_A_Conversion\CAC-master\result_save\sensitivity_analysis\global_sensitivity\mat_save_p10')
gres=[];lres=[];
ges=[];les=[];
load('base.mat');
%res=res-base
Lab_path={'E->P1','E->P2','E->M','E->A','P1->E','P1->P2','P1->M','P1->A','P2->E','P2->P1','P2->M','P2->A','M->E','M->P1','M->P2','M->A','A->E','A->P1','A->P2','A->M'};
Label={'g_{MEK}','g_{ERK}','g_{CEBP}','g_{PPAR}','k_{MEK}','k_{ERK}','k_{CEBP}','k_{PPAR}','lambda_{EM}','lambda_{ME}','lambda_{EE}','lambda_{MC}','lambda_{PC}','lambda_{EC}','lambda_{MP}','lambda_{CP}','lambda_{EP}','n_{EM}','n_{ME}','n_{EE}','n_{MC}','n_{PC}','n_{EC}','n_{MP}','n_{CP}','n_{EP}','MEK_{MC}','MEK_{MP}','MEK0_{ME}','ERK0_{EC}','ERK0_{EP}','CEBP0_{CP}','PPAR_{PC}','ERK0_{EM}','ERK0_{EE}','TGF}','rkip0_{rM}','MEKi}','Rosi','lambda_{EEi}','ERK0_{EEi}','n_{EEi}','lambda_{MM}','MEK0_{MM}','n_{MM}','MEK0_{Ml}','rkip0_{rs}','oct40_{ol}','bach0_{br}','bach0_{bb}','g_{Z}','g_{o}','g_{M}','g_{s}','g_{m1}','g_{m2}','g_{m3}','g_{p}','g_{rk}','g_{let}','g_{lin}','g_{b}','k_{Z}','k_{o}','k_{M}','k_{s}','k_{m1}','k_{m2}','k_{m3}','k_{p}','k_{rk}','k_{let}','k_{lin}','k_{b}','lambda_{sZ}','lambda_{ZZ}','lambda_{m2Z}','lambda_{m1Z}','lambda_{po}','lambda_{oo}','lambda_{lo}','lambda_{m1o}','lambda_{pM}','lambda_{m1M}','lambda_{ss}','lambda_{m3s}','lambda_{ls}','lambda_{om1}','lambda_{Zm1}','lambda_{pm1}','lambda_{om2}','lambda_{pm2}','lambda_{Zm2}','lambda_{sm2}','lambda_{sm3}','lambda_{Zm3}','lambda_{pm3}','lambda_{Mp}','lambda_{br}','lambda_{sr}','lambda_{rl}','lambda_{llet}','lambda_{let}','lambda_{lin}','lambda_{llin}','lambda_{m2le}','lambda_{bb}','lambda_{lb}','lambda_{rM}','lambda_{Ml}','lambda_{rs}','lambda_{ol}','n_{sZ}','n_{ZZ}','n_{m2Z}','n_{m1Z}','n_{po}','n_{oo}','n_{lo}','n_{m1o}','n_{pM}','n_{m1M}','n_{ss}','n_{m3s}','n_{ls}','n_{om1}','n_{Zm1}','n_{pm1}','n_{om2}','n_{pm2}','n_{Zm2}','n_{sm2}','n_{sm3}','n_{Zm3}','n_{pm3}','n_{Mp}','n_{br}','n_{sr}','n_{rl}','n_{llet}','n_{let}','n_{lin}','n_{llin}','n_{m2le}','n_{bb}','n_{lb}','n_{rM}','n_{Ml}','n_{rs}','n_{ol}','Z0_{ZZ}','Z0_{Zm1}','Z0_{Zm2}','Z0_{Zm3}','oct40_{oo}','oct40_{om1}','oct40_{om2}','MD0_{Mp}','snai10_{sZ}','snai10_{ss}','snai10_{sm2}','snai10_{sm3}','snai10_{sr}','miR1450_{m1Z}','miR1450_{m1o}','miR1450_{m1M}','miR2000_{m2Z}','miR2000_{m2le}','miR340_{m3s}','p0_{po}','p0_{pM}','p0_{pm1}','p0_{pm2}','p0_{pm3}','P530','rkip0_{rl}','let0_{ls}','let0_{let}','let0_{ll}','let0_{lb}','lin0_{lo}','lin0_{llet}','lin0_{lin}','rkip0_{rli}','lambda_{rli}','n_{rli}','miR2000_{m2li}','lambda_{m2li}','n_{m2li}'};

dk(1)=2;dk(2)=5;
if dk(1)<dk(2)
    gd=1;
    gt=0;
else
    gt=1;
    gd=0;
end
site(1)=(dk(1)-1)*4+(dk(2)-gd);
site(2)=(dk(2)-1)*4+(dk(1)-gt);

for i=1:189
  %base=rearrange(ycell,action);
   mat1= strcat(num2str(i),'1.mat');
   mat2=strcat(num2str(i),'1action.mat');
   load(mat1)
   load(mat2)
   gres(i,:) = rearrange(ycell,action);  
   ges(i,:)=gres(i,:)-base;
end

for i=1:189
% base=rearrange(ycell,action);
    mat1= strcat(num2str(i),'-1.mat');
    mat2=strcat(num2str(i),'-1action.mat');
    load(mat1)
    load(mat2)
    lres(i,:) = rearrange(ycell,action);  
    les(i,:)=lres(i,:)-base;
end

les=les./base;les(les==-1)=0;
les_index_del=les~=0;
ges=ges./base;ges(ges==-1)=0;
ges_index_del=ges~=0;
[Ales,index_l] = sort(abs(les),'descend');[Ages,index_g] = sort(abs(ges),'descend');
up=25;

subplot(1,2,1)
athh=[];
athh(:,1) = les(index_l(1:up,site(1)),site(1));athh(:,2) = les(index_l(1:up,site(1)),site(2));
bh=barh(athh);bh(1).FaceColor=[1 0 1];bh(2).FaceColor=[0 1 1];
hold on 
set(gca, 'YTick', 1:1:up, 'YTickLabel',Label(index_l(1:up,site(1))));caxis([0 1]);
xlabel('ΔS/S','FontSize',16);ylabel('Parameters','FontSize',16);[M,N]=size(athh);set(gca,'Clim',[0 1]);
C=zeros(2,3);C(1,1)=1;C(1,2)=0;C(1,3)=1;C(2,1)=0;C(2,2)=1;C(2,3)=1;colormap(C);
h1=legend([bh(2) bh(1)], Lab_path{site(2)}, Lab_path{site(1)});
set(h1,'Position',[-0.05 0.82 0.5 0.06],'FontSize',14);
legend('boxoff');
title('A (Increase)','position',[0.1,up+0.5],'FontSize',16);
%title('C (Increase)','position',[-0.02,23.6],'FontSize',16)
%}

subplot(1,2,2)
athh=[];
athh(:,1) = ges(index_g(1:up,site(1)),site(1));athh(:,2) = ges(index_g(1:up,site(1)),site(2));
bh=barh(athh);bh(1).FaceColor=[1 0 1];bh(2).FaceColor=[0 1 1];
hold on 
set(gca, 'YTick', 1:1:up, 'YTickLabel',Label(index_g(1:up,site(1))));caxis([0 1]);
xlabel('ΔS/S','FontSize',16);ylabel('Parameters','FontSize',16);[M,N]=size(athh);set(gca,'Clim',[0 1]);
C=zeros(2,3);C(1,1)=1;C(1,2)=0;C(1,3)=1;C(2,1)=0;C(2,2)=1;C(2,3)=1;colormap(C);
h2=legend([bh(2) bh(1)], Lab_path{site(2)}, Lab_path{site(1)});set(h2,'Position',[0.39 0.82 0.5 0.06],'FontSize',14);
legend('boxoff');
title('B (Decrease)','position',[0.1,up+0.5],'FontSize',16);
%title('D (Decrease)','position',[-0.03,23.6],'FontSize',16)
%}

function  out = rearrange(ycell,action)
out=zeros(1,20);
for j=1:size(ycell,2)
      for k=1:size(ycell,1)
          if j~=k              
YJ1(:,1)=ycell{j,k}(:,1);
YJ1(:,2)=ycell{j,k}(:,end);
dk(1)=0;dk(2)=0;
for ii=1:2
 if YJ1(1,ii)<200
     dk(ii)=1;
 elseif  500<YJ1(1,ii)&&YJ1(1,ii)<1500
     dk(ii)=2;
 elseif YJ1(1,ii)>5200 && YJ1(13,ii)>6000
     dk(ii)=4;
 elseif YJ1(1,ii)>5000 && YJ1(15,ii)>45
     dk(ii)=5;
 else
     dk(ii)=3;
 end
end
if dk(1)<dk(2)
    gd=1;
else
    gd=0;
end
site=(dk(1)-1)*4+(dk(2)-gd);
 out(site)=action(j,k);

          end
  end
end
end