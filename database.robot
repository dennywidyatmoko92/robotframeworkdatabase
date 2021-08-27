*** Settings ***
Library    SeleniumLibrary    
Library    DatabaseLibrary    
Library    OperatingSystem   
Library    pymysql
Library    FakerLibrary         
Suite Setup    Connect To Database    pymysql    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}    dbConfigFile=default.cfg 



*** Variables ***
${DBName}    mydb
${DBUser}    dennywidy
${DBPass}    root
${DBHost}    127.0.0.1
${DBPort}    3306

*** Keywords ***

generate
     ${id}    FakerLibrary.Random Int    min=0    max=999    step=1
  ${name}=          FakerLibrary.Name
  ${email}=         FakerLibrary.Email    mail.com
  ${phoneNumber}=   FakerLibrary.Random Number    digits=11   fix_len=${TRUE}
  ${city}=          FakerLibrary.City
  ${address}=       FakerLibrary.Address
  ${postalCode}=    FakerLibrary.Postcode

  &{DATAUSER}=    Create Dictionary    NAME=${name}
  ...   EMAIL=${email}    PHONE=+62${phoneNumber}
  ...   CITY=${city}      ADDRESS=${address}
  ...   POSTCODE=${postalCode}
  ...    ID=${id}
  [Return]    ${DATAUSER}
            
     
    
    
    


*** Test Cases ***




       
#create table data diri
#    ${output}=    Execute Sql String    create table datadiri(id integer,nama varchar(20), alamat varchar(20))    
#    Log To Console    ${output}    
#    Should Be Equal As Strings    ${output}    None

insert data diri
    ${id}    FakerLibrary.Random Int    min=0    max=999    step=1
    ${name}=          FakerLibrary.Name
  ${email}=         FakerLibrary.Email    mail.com
  ${phoneNumber}=   FakerLibrary.Random Number    digits=11   fix_len=${TRUE}
  ${city}=          FakerLibrary.City
  ${address}=       FakerLibrary.Address
  ${postalCode}=    FakerLibrary.Postcode

  &{DATAUSER}=    Create Dictionary    NAME=${name}
  ...   EMAIL=${email}    PHONE=+62${phoneNumber}
  ...   CITY=${city}      ADDRESS=${address}
  ...   POSTCODE=${postalCode}
  ...    ID=${id}

    
    ${output}=    Execute Sql String    insert into datadiri values(${DATAUSER.ID},"${DATAUSER.NAME}","${DATAUSER.ADDRESS}");
    Log To Console    ${output} 


check record
    Check If Exists In Database    select id from mydb.datadiri where id=1;
    
check tidak ada
    Check If Not Exists In Database    select id from mydb.datadiri where id=0;    
check person table exist in my
    Table Must Exist    datadiri    
              
verify row count is zero
    Row Count Is 0    select * from mydb.datadiri where id=1343435;     
    
verify row count is equal to some value
    Row Count Is Equal To X    select * from mydb.datadiri where id=1;    1      
    
retrieve record
    @{queryresult}=    query    select * from mydb.datadiri order by nama asc
    Log To Console    many @{queryresult}    
    
update data
    ${output}=    Execute Sql String    update mydb.datadiri set nama="embuh",alamat="embuh" where id=1;
    Log To Console    ${output}    
    Should Be Equal As Strings    ${output}    ${None}    
    
delete data
    ${output}=    Execute Sql String    delete from mydb.datadiri where id=1;    
      Log To Console    ${output}    
    Should Be Equal As Strings    ${output}    ${None} 
    
check username
    ${output}=    Query    select nama from mydb.datadiri where id=584;    
    Log To Console    ${output}    
