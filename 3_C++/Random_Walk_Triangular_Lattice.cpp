#include <iostream>
#include <cmath>
#include <stdlib.h>
#include <fstream>
#define P acos(-1)
using namespace std;
class LnReg
{
private:
double *x;
double *y;
int n;
public:
LnReg(int nd); 
~LnReg(); 
void SetData(int i,double xd,double yd);
void Solv(double &a,double &b);
};
LnReg::LnReg(int nd)
{
 n=nd;
x=new double[n];
y=new double[n];
}
LnReg::~LnReg()
{
delete []x;
delete []y;
}
void LnReg::SetData(int i, double xd,double yd)
{
x[i]=xd;
y[i]=yd;
}
void LnReg::Solv(double &a,double &b)
{
double sumx=0, sumy=0, sumx2=0, sumxy=0;
for(int i=0; i<n; i++)
{
sumx+=x[i];
sumy+=y[i];
sumx2+=x[i]*x[i];
sumxy+=x[i]*y[i];
}
double D=n*sumx2-sumx*sumx;
a=(n*sumxy-sumy*sumx)/D;
b= (sumx2*sumy-sumx*sumxy)/D;
}
int main(){
	int j,num_itteration,i,u,Q,W;
	srand(time(NULL));
	double B,O;
	cout<<"please Enter the step"<<'\n';
	cin>>u;
	cout<<"please Enter the probability:"<<'\n';
	cin>>B;
	cout<<"please isert number of itteration"<<'\n';
	cin>>num_itteration;
	int v[num_itteration][u];
	double x[num_itteration][u],y[num_itteration][u],R[num_itteration][u],sumRQ[u];
	double sumR[u],steps[u];
	x[0][0]=1;y[0][0]=1;
	//R[0][0]==sqrt(2);
	ofstream out1("direction");
	ofstream out2("point.txt");
	ofstream out3("RvsN.txt");
	ofstream out4("Sum of the R.txt");
	ofstream out5("the averag of the R.txt");
	ofstream out6("R.txt");
	ofstream out7("R1.txt");
	for(j=0;j<num_itteration;j++){
	for(i=0;i<u;i++){
	Q=(6*(rand()/(RAND_MAX+1.0)))+1.0;;
	switch (Q){
		case (1):{
			O=rand()/(RAND_MAX+1.0);
			if (O<B) {
				v[j][i]=1;
				out1<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<v[j][i]<<'\n';}
				else {
					v[j][i]=3;
					out1<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<v[j][i]<<'\n';
				}
			
			break;}
	    case (2):{
			O=rand()/(RAND_MAX+1.0);
			if (O<(1-B)) {
				v[j][i]=0;
				out1<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<v[j][i]<<'\n';
			}
			else {
					v[j][i]=3;
					out1<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<v[j][i]<<'\n';
				}
			break;}
			case (3):{
			O=rand()/(RAND_MAX+1.0);
			if (O<(1-B)) {
				v[j][i]=0;
				out1<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<v[j][i]<<'\n';}
			
			else {
					v[j][i]=3;
					out1<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<v[j][i]<<'\n';
				}
			break;}
			case (4):{
			O=rand()/(RAND_MAX+1.0);
			if (O<(1-B)) {
				v[j][i]=0;
				out1<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<v[j][i]<<'\n';
			}
			else {
					v[j][i]=3;
					out1<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<v[j][i]<<'\n';
				}
			break;}
			case (5):{
			O=rand()/(RAND_MAX+1.0);
			if (O<(1-B)) {
				v[j][i]=0;
				out1<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<v[j][i]<<'\n';
			}
			else {
					v[j][i]=3;
					out1<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<v[j][i]<<'\n';
				}
			break;}
			case (6):{
			O=rand()/(RAND_MAX+1.0);
			if (O<(1-B)) {
				v[j][i]=0;
				out1<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<v[j][i]<<'\n';
			}
			else {
					v[j][i]=3;
					out1<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<v[j][i]<<'\n';
				}
			break;}
		}
}
	for (i=0;i<u;i++){
	W=(6*(rand()/(RAND_MAX+1.0)))+1.0;
	switch (W){
		case (1):{
			if (v[j][i]==1){
				x[j][i+1]=x[j][i]+cos(0);
				y[j][i+1]=y[j][i]+sin(0);
				R[j][i]=sqrt(x[j][i]*x[j][i]+y[j][i]*y[j][i]);
				out2<<x[j][i]<<'\t'<<y[j][i]<<'\n';
				out3<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<R[j][i]<<'\n';
			}
				else if (v[j][i]==0){
					x[j][i+1]=x[j][i]+cos(300*P/180);
					y[j][i+1]=y[j][i]+sin(300*P/180);
					R[j][i]=sqrt(x[j][i]*x[j][i]+y[j][i]*y[j][i]);
					out2<<x[j][i]<<'\t'<<y[j][i]<<'\n';
					out3<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<R[j][i]<<'\n';
				}
				else {
					x[j][i+1]=x[j][i];
					y[j][i+1]=y[j][i];
					R[j][i]=sqrt(x[j][i]*x[j][i]+y[j][i]*y[j][i]);
					out2<<x[j][i]<<'\t'<<y[j][i]<<'\n';
					out3<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<R[j][i]<<'\n';
				}
					break;}
					case (2):{
			if (v[j][i]==1){
				x[j][i+1]=x[j][i]+cos(60*P/180);
				y[j][i+1]=y[j][i]+sin(60*P/180);
				R[j][i]=sqrt(x[j][i]*x[j][i]+y[j][i]*y[j][i]);
				out2<<x[j][i]<<'\t'<<y[j][i]<<'\n';
				out3<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<R[j][i]<<'\n';
			}
				else if (v[j][i]==0){
					x[j][i+1]=x[j][i]+cos(240*P/180);
					y[j][i+1]=y[j][i]+sin(240*P/180);
					R[j][i]=sqrt(x[j][i]*x[j][i]+y[j][i]*y[j][i]);
					out2<<x[j][i]<<'\t'<<y[j][i]<<'\n';
					out3<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<R[j][i]<<'\n';
				}
				else {
					x[j][i+1]=x[j][i];
					y[j][i+1]=y[j][i];
					R[j][i]=sqrt(x[j][i]*x[j][i]+y[j][i]*y[j][i]);
					out2<<x[j][i]<<'\t'<<y[j][i]<<'\n';
					out3<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<R[j][i]<<'\n';
				}
					break;}
					case (3):{
			if (v[j][i]==1){
				x[j][i+1]=x[j][i]+cos(120*P/180);
				y[j][i+1]=y[j][i]+sin(120*P/180);
				R[j][i]=sqrt(x[j][i]*x[j][i]+y[j][i]*y[j][i]);
				out2<<x[j][i]<<'\t'<<y[j][i]<<'\n';
				out3<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<R[i]<<'\n';
			}
				else if (v[j][i]==0){
					x[j][i+1]=x[j][i]+cos(180*P/180);
					y[j][i+1]=y[j][i]+sin(180*P/180);
					R[j][i]=sqrt(x[j][i]*x[j][i]+y[j][i]*y[j][i]);
					out2<<x[j][i]<<'\t'<<y[j][i]<<'\n';
					out3<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<R[j][i]<<'\n';
				}
				else {
					x[j][i+1]=x[j][i];
					y[j][i+1]=y[j][i];
					R[j][i]=sqrt(x[j][i]*x[j][i]+y[j][i]*y[j][i]);
					out2<<x[j][i]<<'\t'<<y[j][i]<<'\n';
					out3<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<R[j][i]<<'\n';
				}
					break;}
					case (4):{
			if (v[j][i]==1){
				x[j][i+1]=x[j][i]+cos(180*P/180);
				y[j][i+1]=y[j][i]+sin(180*P/180);
				R[j][i]=sqrt(x[j][i]*x[j][i]+y[j][i]*y[j][i]);
				out2<<x[j][i]<<'\t'<<y[j][i]<<'\n';
				out3<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<R[j][i]<<'\n';
			}
				else if (v[j][i]==0){
					x[j][i+1]=x[j][i]+cos(120*P/180);
					y[j][i+1]=y[j][i]+sin(120*P/180);
					R[j][i]=sqrt(x[j][i]*x[j][i]+y[j][i]*y[j][i]);
					out2<<x[j][i]<<'\t'<<y[j][i]<<'\n';
					out3<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<R[j][i]<<'\n';
				}
				else {
					x[j][i+1]=x[j][i];
					y[j][i+1]=y[j][i];
					R[j][i]=sqrt(x[j][i]*x[j][i]+y[j][i]*y[j][i]);
					out2<<x[j][i]<<'\t'<<y[j][i]<<'\n';
					out3<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<R[j][i]<<'\n';
				}
					break;}
					case (5):{
			if (v[j][i]==1){
				x[j][i+1]=x[j][i]+cos(240*P/180);
				y[j][i+1]=y[j][i]+sin(240*P/180);
				R[j][i]=sqrt(x[j][i]*x[j][i]+y[j][i]*y[j][i]);
				out2<<x[j][i]<<'\t'<<y[j][i]<<'\n';
				out3<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<R[j][i]<<'\n';
			}
				else if (v[j][i]==0){
					x[j][i+1]=x[j][i]+cos(60*P/180);
					y[j][i+1]=y[j][i]+sin(60*P/180);
					R[j][i]=sqrt(x[j][i]*x[j][i]+y[j][i]*y[j][i]);
					out2<<x[j][i]<<'\t'<<y[j][i]<<'\n';
					out3<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<R[j][i]<<'\n';
				}
				else {
					x[j][i+1]=x[j][i];
					y[j][i+1]=y[j][i];
					R[j][i]=sqrt(x[j][i]*x[j][i]+y[j][i]*y[j][i]);
					out2<<x[j][i]<<'\t'<<y[j][i]<<'\n';
					out3<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<R[j][i]<<'\n';
				}
					break;}
					case (6):{
			if (v[j][i]==1){
				x[j][i+1]=x[j][i]+cos(300*P/180);
				y[j][i+1]=y[j][i]+sin(300*P/180);
				R[j][i]=sqrt(x[j][i]*x[j][i]+y[j][i]*y[j][i]);
				out2<<x[j][i]<<'\t'<<y[j][i]<<'\n';
				out3<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<R[j][i]<<'\n';
			}
				else if (v[j][i]==0){
					x[j][i+1]=x[j][i]+cos(0);
					y[j][i+1]=y[j][i]+sin(0);
					R[j][i]=sqrt(x[j][i]*x[j][i]+y[j][i]*y[j][i]);
					out2<<x[j][i]<<'\t'<<y[j][i]<<'\n';
					out3<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<R[j][i]<<'\n';
				}
				else {
					x[j][i+1]=x[j][i];
					y[j][i+1]=y[j][i];
					R[j][i]=sqrt(x[j][i]*x[j][i]+y[j][i]*y[j][i]);
					out2<<x[j][i]<<'\t'<<y[j][i]<<'\n';
					out3<<"{"<<j<<"}"<<"{"<<i<<"}"<<'\t'<<R[j][i]<<'\n';
				}
					break;}
					
}
}
}
for(i=0;i<u;i++){
for(j=0;j<num_itteration;j++){
	
	sumR[i]+=R[j][i];
	
}
	out4<<i<<'\t'<<sumR[i]<<'\n';
	sumRQ[i]=sumR[i]/(num_itteration);
    out5<<i<<'\t'<<sumRQ[i]<<'\n';
}

for(i=0;i<u;i++){
	steps[i]=i;
	out7<<steps[i]<<'\n';
}
LnReg StLn(u);
double a,b;
for(i=0; i<u; i++)
StLn.SetData(i,steps[i],sumRQ[i]);
StLn.Solv(a,b);
cout << "Solution: " << endl;
cout << "a = " << a << endl<< "b = " << b << endl;
cout << " or " << endl;
cout << " y = " << a << "*x " << "+ " << b << endl;
out1.close();
out2.close();
out3.close();
out4.close();
out5.close();
out6.close();
out7.close();

	return 0;
}
