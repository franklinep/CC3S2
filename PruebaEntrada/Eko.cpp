#include <bits/stdc++.h>
#define fast_io ios_base::sync_with_stdio(false); cin.tie (NULL)
using namespace std;
typedef long long ll;
const int INF = 2e9;
int n;
ll m;
vector<int> h;

bool p(int mid, int n, const vector<int>& h){
	ll sum = 0;
	for (int i = 0; i < n; ++i){
	 	if(h[i]-mid > 0) {
	 		sum += h[i]-mid;
	 	}
	}
	if(sum >= m) return true;
	return false;
}

void solve(){
	cin >> n >> m;
	h.resize(n);
	for (int i = 0; i < n; ++i) cin>>h[i];
	int low = 0, high = INF;
	while(low < high){
		int mid = (low+high+1)/2;
		if(p(mid,n,h)) low = mid;
		else high = mid-1;
	}
	cout << low;
	return;
}	
int main(){
	fast_io;
	solve();
}