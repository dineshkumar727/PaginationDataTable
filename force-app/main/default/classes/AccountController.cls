/**
 * @description       : 
 * @author            : Dinesh Kumar R
 * @group             : 
 * @last modified on  : 11-19-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class AccountController {

        @AuraEnabled public static String getAccountList(Integer pageSize, Integer pageNumber){
            String jsonDT = '';
             
            Integer offset = (pageNumber - 1) * pageSize;
             

            Integer totalRecords = [SELECT COUNT() FROM Account];
            Integer recordEnd = pageSize * pageNumber;
             
            AccountDTWrapper objDT =  new AccountDTWrapper();  
            objDT.pageSize = pageSize;
            objDT.pageNumber = pageNumber;
            objDT.recordStart = offset + 1;
            objDT.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
            objDT.totalRecords = totalRecords;
            objDT.accounts = [SELECT Id, Name, Industry, AnnualRevenue FROM Account ORDER BY Name LIMIT :pageSize OFFSET :offset];
           List<Account> results=new List<Account>();
           results=objDT.accounts;
           system.debug(results);
            jsonDT = JSON.serialize(objDT);
            return jsonDT;
        }
         
        public class AccountDTWrapper {
            public Integer pageSize {get;set;}
            public Integer pageNumber {get;set;}
            public Integer totalRecords {get;set;}
            public Integer recordStart {get;set;}
            public Integer recordEnd {get;set;}
            public List<Account> accounts {get;set;}
        }
    }