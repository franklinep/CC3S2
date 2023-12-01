#include <bits/stdc++.h>
#define fast_io ios_base::sync_with_stdio(false); cin.tie (NULL)
using namespace std;
typedef long long ll;

int opt, n, pos, prct;
vector<int> flow;

void solve(){
	cin >> n;
	flow.resize(n);
	for(int i=0; i<n; ++i) cin >> flow[i];
	while(cin >> opt){ 
		if(opt==77) break;
		if(opt==99){
			cin >> pos >> prct;
			int aux = flow[pos-1];
			flow[pos-1] = round(flow[pos-1]*(prct/100.0));
			flow.insert(flow.begin() + pos, aux-flow[pos-1]);
			cin.sync(); // Limpiar el buffer
		}		
		if(opt==88){
			cin >> pos;
			flow[pos-1] += flow[pos];	
			flow.erase(flow.begin() + pos);
		    cin.sync(); // Limpiar el buffer
		}
	}

	for(int e : flow){
		cout << e << ' ';
	}
	return;
}

int main(){
	fast_io;
	solve();
	return 0;
}