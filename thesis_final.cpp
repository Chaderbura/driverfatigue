#include<bits/stdc++.h>
using namespace std;

int main()
{
    vector<int>mouth_height,mouth_width,pressure;
    vector<float>eye_left,eye_right;

    int yawn=0,frames=0;
    int p,q,t;
    float r,s;
    freopen("Alldata_modified.txt","r",stdin);
    for(int i=0;i<120;i++)
    {
        cin>>p>>q>>r>>s>>t;
        mouth_height.push_back(p);
        mouth_width.push_back(q);
        eye_left.push_back(r);
        eye_right.push_back(s);
        pressure.push_back(t);
    }
    int yawnface=0;
    int last_yawn;
    int eyesclosed=0;
    int lowpressure=0;
    int highpressure=0;
    float drowsyface=0;
    float drowsy=0;
    int maybe=0;
    int notdrowsy=0;

    for(int i=0;i<120;i++)
    {
        if(mouth_height[i]>22 && mouth_width[i]>30 && mouth_width[i]<50)
        {
            yawnface++;
            last_yawn=i;
        }
        if(i>3 && (eye_left[i]<.8 && eye_right[i]<.8) && (eye_left[i-1]<.8 && eye_right[i-1]<.8) && (eye_left[i-2]<.8 && eye_right[i-2]<.8))
        {
            eyesclosed++;
        }
        else{
            eyesclosed=0;
        }

        if(i>4 && pressure[i]<220 && pressure[i-1]<220 && pressure[i-2]<220 && pressure[i-3]<220 && pressure[i-4]<220)
        {
            lowpressure++;
        }
        else if(i>4 && pressure[i]>940 && pressure[i-1]>940 && pressure[i-2]>940 && pressure[i-3]>940 && pressure[i-4]>940){
            highpressure++;
        }
        else{
            lowpressure=0;
            highpressure=0;
        }

        //count drowsy faces
        if((mouth_height[i]>22 && mouth_width[i]>30 && mouth_width[i]<45) || (eye_left[i]<.8 && eye_right[i]<.8))
        {
            drowsyface++;
        }

        if(eyesclosed>0 && ((i-60)<last_yawn) && lowpressure>0)
        {
            drowsy++;
        }
        else if(eyesclosed>0 &&((i-60)>last_yawn) && lowpressure>0)
        {
            drowsy++;
        }
        else if(eyesclosed>0 &&((i-60)>last_yawn) && highpressure>0)
        {
            drowsy++;
        }
        else if(eyesclosed==0 &&((i-60)<last_yawn) && lowpressure>0)
        {
            maybe++;
        }
        else{
            notdrowsy++;
        }

    }

    cout<<"Total FACES 120."<<endl;
    cout<<"Total DROWSY faces: "<<drowsyface<<endl;
    cout<<"Total YAWN faces: "<<yawnface<<endl;
    cout<<"Total Drowsiness DETECTED: "<<drowsy<<endl;
    cout<<"\nDrowsy FACE detected MANUALLY: 35"<<endl;
    cout<<"Drowsiness detected MANUALLY: 5\n"<<endl;
    cout<<"Accuracy of drowsy faces: "<<(drowsyface/35)*100<<"%\n"<<endl;
    cout<<"Accuracy of drowsiness: "<<(drowsy/5)*100<<"%\n"<<endl;
    cout<<"Chances of drowsiness: "<<maybe<<endl;

}
