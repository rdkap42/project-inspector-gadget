'''
Created on May 27, 2015

@author: hlamba
'''
import os
import sys
import json
import httplib2
import array

key='48c399b47170f0178aa15a245013cd9a119e8fba'

def request(key,url):
    base_url='http://api.census.gov/data/2010/sf1?key='
    http = httplib2.Http()
    url = base_url+str(key)+url
    print url
    headers = {}
    response, content = http.request(url,'GET', headers=headers)
    #print content
    return content

def get_pop_data(out_dir):
    state_id="17" #Illinois
    county_id="031" #Cook County
    
    out_file=os.path.join(out_dir,"Population_Statistics.txt")
    fw=open(out_file,"w")
    url="&get=P0010001,P0120001,P0120002,P0180001,P0180002,P0180003,P0180004,P0180005,P0180006,P0180007,P0180008,P0180009&for=block+group:*&in=state:"+str(state_id)+"+county:"+str(county_id)
    fw.write("TotalPopulation\tGenderPopulation\tMales\tFemales\tNum_Households\tFamily_Households\tHusband_Wife\tOther\tMaleHH\tFemaleHH\tLO_FemaleHH\tNLO_FemaleHH\n")
    response=request(key,url)
    print response
    for line in response.split("\n"):
        if("P0010001" not in line):
            line=line.replace("[","")
            line=line.replace("]","")
            line=line.replace("\"","")
            split=line.split(",")
        
            tot_pop=int(split[0])
            gender_pop=int(split[1])
            male_pop=int(split[2])
            female_pop=int(split[3])
            num_households=int(split[4])
            family_households=int(split[5])
            husband_wife=int(split[6])
            other_family=int(split[7])
            male_householder=int(split[8])
            female_householder=int(split[9])
            lo_female_householder=int(split[10])
            nlo_female_householder=int(split[11])
            state_id=str(split[12])
            county_id=str(split[13])
            tract=str(split[14])
            block_group=str(split[15])
        
            fw.write(str(tot_pop)+"\t"+str(gender_pop)+"\t"+str(male_pop)+"\t"+str(female_pop)+"\t"+str(num_households)+"\t"+
                 str(family_households)+"\t"+str(husband_wife)+"\t"+str(other_family)+"\t"+str(male_householder)+"\t"+
                 str(female_householder)+"\t"+str(lo_female_householder)+"\t"+str(nlo_female_householder)+"\t"+
                 str(state_id)+"\t"+str(county_id)+"\t"+str(tract)+"\t"+str(block_group)+"\n")
        
    fw.close()


out_dir="/Users/hlamba/Documents/DSSG/Project_Week1/AgentSmith/Data/"
get_pop_data(out_dir)