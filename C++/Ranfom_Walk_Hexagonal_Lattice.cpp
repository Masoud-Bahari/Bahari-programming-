#include <iostream>
#include <fstream>
#include <cmath>
#include <stdlib.h>
using namespace std;
int main(){
	int i;
	float r=0;
	float x=0.0 , y=0.0;
	srand(time(NULL));
	int Q;
	//braiae rasm nemodar R vs N;
	ofstream out2("RvsN.txt");
	ofstream out1("Hexa.txt");
	for (i=0;i<=50000;i++){
		//dar shabake hexagonal dar har harekat 3 shart mitavan dasht,baad az herekat aval 3 shart digar mitavan dasht k zavieie
		//harekat ra taaiin mikonad,baraie inke ehtemal mosavi dar in 3 harekat barghara bashad baghi mande ra bar 3 darnahayat be
		//ezafe 1 migirim,baraie deghat bishtar adade pi ra ba teedade aashar bishtar minevisim,"meghdare adade pi ra az internet 
		//gereftam".baraye ijad shabake hexa gonal dar har case ye sharte mahdod konande bargharar mikonim.
		Q=(rand()%3)+1;
		out2<<i<<'\t'<<r<<'\n';
		out1<<x<<'\t'<<y<<'\n';
		switch(Q){
			case (1):{
			if(i%2==0){
			x=x+cos(0);
			y=y+sin(0);
		}else {
			x=x+cos(60*3.14159265358979323846264338327950288419716939937510/180);
			y=y+sin(60*3.14159265358979323846264338327950288419716939937510/180);}
			
			r=sqrt(x*x+y*y);
			
			 break;}
		
		case (2):{
			if(i%2==0){
			x=x+cos(120*3.14159265358979323846264338327950288419716939937510/180);
			y=y+sin(120*3.14159265358979323846264338327950288419716939937510/180);
		}else {
			x=x+cos(180*3.14159265358979323846264338327950288419716939937510/180);
			y=y+sin(180*3.14159265358979323846264338327950288419716939937510/180);
			}
			
			r=sqrt(x*x+y*y);
			break;}
			
			case (3):{ 
			if (i%2==0){
				x=x+cos(240*3.14159265358979323846264338327950288419716939937510/180); 
		     	y=y+sin(240*3.14159265358979323846264338327950288419716939937510/180);}
		else {
			x=x+cos(300*3.14159265358979323846264338327950288419716939937510/180);
		    y=y+sin(300*3.14159265358979323846264338327950288419716939937510/180);}
		    
		    r=sqrt(x*x+y*y);
		break;}		 
		
}
}
	out1.close();
	out2.close();
		return 0;
	}
	
