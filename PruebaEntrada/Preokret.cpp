#include <bits/stdc++.h>
#define fast_io ios_base::sync_with_stdio(false); cin.tie (NULL)
using namespace std;
typedef long long ll;

int a, b, dif;
vector<int> as;
vector<int> bs;
int aux=0;

int ptsA=0, ptsB=0;
int ans1=0, ans2=0;

void solve(){
	cin >> a; as.resize(a);
	for(int i=0; i<a; ++i) cin >> as[i];
	cin >> b; bs.resize(b);
	for(int j=0; j<b; ++j) cin >> bs[j];
	int i=0,j=0;
	//Otra solución: Sería iterar segundo por segundo debido
	// a que este caso particular solo tiene un max de 2880 segundos.
	
	// Solución con condicionales.
	while(i<int(as.size()) || j<int(bs.size())){
		//task 1
		if(i>=int(as.size())){
			if(bs[j]<1440) ans1++;
			ptsB++; j++;
		}else if(j>=int(bs.size())){
			if(as[i]<1440) ans1++;
			ptsA++; i++;
		}else{
			if(as[i]<bs[j]){
				if(as[i]<1440) ans1++;
				ptsA++; i++;
			}else if(as[i]>bs[j]){
				if(bs[j]<1440) ans1++;
				ptsB++; j++;
			}else{
				if(bs[j]<1440) ans1+=2;
				ptsA++; ptsB++;
				i++; j++;
			}
		}
		//task2
		dif = ptsA-ptsB;
		if(dif+aux==0) ans2++;
		if(abs(dif)) aux = dif; //dif = 1 o -1

	}
	cout << ans1 << '\n' << ans2;
	return;
}

int main(){
	fast_io;
	solve();
	return 0;
}