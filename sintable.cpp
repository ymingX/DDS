#include<stdio.h>
#include<cmath>
const int add_wid=12;
const int data_wid=16;
const long double pi=3.14159265;
using namespace std;
int main()
{
    freopen("sintable.mif","w",stdout);
    printf("width=%d;\ndepth=%d;\naddress_radix=uns;\ndata_radix=uns;\nContent Begin\n",data_wid,1<<add_wid);

    for(int i=0;i<(1<<add_wid);i++)
    {
        int x=( (1<<(data_wid-1) )-1)*sin(2*pi*i/(1<<add_wid))+(1<<(data_wid-1));
        printf("%d:%d;\n",i,x);
    }
    printf("END;");
    return 0;
}