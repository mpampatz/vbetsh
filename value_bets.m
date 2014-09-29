#! /usr/bin/octave -qf


echo off;
warning ("off");


arg_list=argv;
cap=str2double(arg_list(1));
match_name=char(arg_list(2));
min_value=str2double(arg_list(3));
category=char(arg_list(4));

odds=importdata("./table"," ",0);

# 1os elegxos: "to match yparxei ston stoiximan?"
if (any(ismember(odds.rowheaders,"Stoiximan"))==1)

# ka8arismos apo skartes stoiximatikes(onomastika)
  odds.data(find(ismember(odds.rowheaders,"BetFair")),:)=[];
  odds.rowheaders(find(ismember(odds.rowheaders,"BetFair")),:)=[];
  
  odds.data(find(ismember(odds.rowheaders,"Fdjeux")),:)=[];
  odds.rowheaders(find(ismember(odds.rowheaders,"Fdjeux")),:)=[];
  
  odds.data(find(ismember(odds.rowheaders,"Iddaa")),:)=[];
  odds.rowheaders(find(ismember(odds.rowheaders,"Iddaa")),:)=[];
  
  odds.data(find(ismember(odds.rowheaders,"PublicBet")),:)=[];
  odds.rowheaders(find(ismember(odds.rowheaders,"PublicBet")),:)=[];
  
# ka8arismos apo skartes stoiximatikes(a3iologika)
  ganiota=sum(1./odds.data,2);
  odds.data(find(ganiota>1.111),:)=[];
  odds.rowheaders(find(ganiota>1.111),:)=[];

# 2os elegxos: "to match paizetai se arketes stoiximatikes?"
  if (size(odds.data,1)>=10) 

# ypologismos aksiwn
    odds.data=double(odds.data);
    A=odds.data(find(ismember(odds.rowheaders,"Stoiximan")),:);
    odds.data(find(ismember(odds.rowheaders,"Stoiximan")),:)=[];
    ganiota=sum(1./odds.data,2);
    P=mean(1./odds.data./ganiota);
    V=A.*P;
    max_value=max(V);
    
# 3os elegxos: "to stoixima pianei tin elaxisti aksia?"
    if (max_value>=min_value) 
      
# ypologismos pontarismatos
      P=round(P(V==max_value)*10000)/100;
      A=A(V==max_value);
      point=['1';'x';'2'];
      point=point(V==max_value);
      bet_to_cap=(max_value-1)./(A-1);
      bet=round(bet_to_cap*cap*10)/10;

# 4os elegxos: "mporw na pontarw?"
      if (bet>=0.0)

# dwse to stoixima
        printf("\033[1A\033[80D\n\033[1;30m%50s\033[0m%53s\n",category," ")
        printf("\033[1A\033[80D\n%50s%10.4f%9.2f%1s%10.2f%10.2f%3s%10s\n\n",match_name, max_value,P,"%",A,bet," eu", point)

      endif
    endif
  endif
endif
