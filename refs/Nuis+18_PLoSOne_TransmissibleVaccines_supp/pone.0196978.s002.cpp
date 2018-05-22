// SIR.cpp : Defines the entry point for the console application.
//



#include <iostream>
#include <math.h>
#include <stdlib.h>
#include <time.h>
#include <fstream>
#include <string>




//Created August 18, 2016
//Edited August 18, 2016

using namespace std;

time_t seconds;



//Here, X[Population][Individual][Locus] and Y[Population][Individual][Locus]
int S[1000], W[1000], V[1000], RV[1000], RW[1000], TMax, t, Replicates, RepCount, SigNow, SigMax;
char FileRootRaw[50], FileRootAvg[50], FileRootFinal[50], Densities[50] = "Densities_", MeanDensities[50] = "MeanDensities_", FinalSize[50] = "FinalSize_";
double BV,BW,Sigma,b,d,DeltaW,DeltaV,v,TotalReactions,TimeOfReaction,Picker,Sum,CurrentTime[1000],UniSeed,SSum,VSum,WSum,RVSum,RWSum,tSum;

ofstream out_Densities;
ofstream out_MeanDensities;
ofstream out_FinalSize;


void Initialize();


int main()
{
	srand ( time(NULL) );

	cout<<"Enter file name for raw densities\n";
	cin >>FileRootRaw;

	cout << "Enter file name for average densities\n";
	cin >> FileRootAvg;

	cout << "Enter file name for Final Sizes\n";
	cin >> FileRootFinal;
	Replicates = 1000;
	

	out_Densities.open(FileRootRaw);

	out_MeanDensities.open(FileRootAvg);

	out_FinalSize.open(FileRootFinal);


	TMax=30000;
	
	out_Densities << "Step,";
	for (RepCount = 0; RepCount < Replicates; RepCount++)
	{
		out_Densities <<"t("<<RepCount<<"),"<< "S(" << RepCount << ")," << "V(" << RepCount << ")," << "W(" << RepCount << ")," << "RV(" << RepCount << ")," << "RW(" << RepCount << "),";
	}
	out_Densities << "\n";

	SigMax = 20;
	Sigma = 0.0;

	for (SigNow = 0; SigNow < SigMax; SigNow++)
	{


		for (RepCount = 0; RepCount < Replicates; RepCount++)
		{
			S[RepCount] = 1000;
			V[RepCount] = 0;
			W[RepCount] = 20;
			RV[RepCount] = 0;
			RW[RepCount] = 0;
			CurrentTime[RepCount] = 0;
		}
		BV = 0.00009;
		//BV = 0.0;
		BW = 0.0002;
		DeltaV = 0.1;
		DeltaW = 0.1;
	

		for (t = 0; t < TMax; t++)
		{

			tSum = 0;
			SSum = 0;
			VSum = 0;
			WSum = 0;
			RVSum = 0;
			RWSum = 0;

			out_Densities << t << ",";
			out_MeanDensities << t << ",";

			for (RepCount = 0; RepCount < Replicates; RepCount++)
			{


				TotalReactions = Sigma*S[RepCount] + BV*S[RepCount] * V[RepCount] + BW*S[RepCount] * W[RepCount] + DeltaV*V[RepCount] + DeltaW*W[RepCount];
				UniSeed = 0;
				while (UniSeed == 0)
				{
					UniSeed = 1.0*rand() / (1.0*RAND_MAX);
				}
				TimeOfReaction = -log(UniSeed) / TotalReactions;

				//tstep = (-1) / (event_rate)* log10(trandom);

				CurrentTime[RepCount] = CurrentTime[RepCount] + TimeOfReaction;
				//if(CurrentTime>0)
				//{
				//	Sigma = 0.5;
				//}

				//choose reaction that occurs

				Sum = 0;
				Picker = 1.0*rand() / (1.0*RAND_MAX);



				if (Picker < Sigma*S[RepCount] / TotalReactions)
				{
					S[RepCount] --;
					V[RepCount] ++;
				}
				Sum = Sum + Sigma*S[RepCount] / TotalReactions;

				if (Picker >= Sum&&Picker < Sum + BV*S[RepCount] * V[RepCount] / TotalReactions)
				{
					S[RepCount] --;
					V[RepCount] ++;
				}
				Sum = Sum + BV*S[RepCount] * V[RepCount] / TotalReactions;

				if (Picker >= Sum&&Picker < Sum + BW*S[RepCount] * W[RepCount] / TotalReactions)
				{
					S[RepCount] --;
					W[RepCount] ++;
				}
				Sum = Sum + BW*S[RepCount] * W[RepCount] / TotalReactions;


				if (Picker >= Sum&&Picker < Sum + DeltaV*V[RepCount] / TotalReactions)
				{
					V[RepCount] --;
					RV[RepCount] ++;
				}
				Sum = Sum + DeltaV*V[RepCount] / TotalReactions;



				if (Picker >= Sum&&Picker < Sum + DeltaW*W[RepCount] / TotalReactions)
				{
					W[RepCount] --;
					RW[RepCount] ++;
				}
				Sum = Sum + DeltaW*W[RepCount] / TotalReactions;




				out_Densities << CurrentTime[RepCount] << "," << S[RepCount] << "," << V[RepCount] << "," << W[RepCount] << "," << RV[RepCount] << "," << RW[RepCount] << ",";


				SSum = SSum + S[RepCount];
				VSum = VSum + V[RepCount];
				WSum = WSum + W[RepCount];
				RVSum = RVSum + RV[RepCount];
				RWSum = RWSum + RW[RepCount];
				tSum = tSum + CurrentTime[RepCount];

				if (CurrentTime[RepCount] > 2000)
				{
					t = TMax + 1;
				}
			}//end replicate loop
			out_MeanDensities << tSum / (1.0*Replicates) << "," << SSum / (1.0*Replicates) << "," << VSum / (1.0*Replicates) << "," << WSum / (1.0*Replicates) << "," << RVSum / (1.0*Replicates) << "," << RWSum / (1.0*Replicates) << "\n";
			out_Densities << "\n";

		}//End time loop
		out_FinalSize << Sigma << ",";
		for (RepCount = 0; RepCount < Replicates; RepCount++)
		{
			out_FinalSize << RW[RepCount]<<",";
		}
		Sigma = Sigma + .0001;
		out_FinalSize << "\n";
	}//end of sigma loop
	

}


