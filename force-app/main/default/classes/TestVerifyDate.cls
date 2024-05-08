@isTest
public class TestVerifyDate {
    @istest
     static void testmethod1() {
        test.startTest();
        VerifyDate.CheckDates(system.today(), system.today()+1);
        test.stopTest();
    }
    @istest
     static void testmethod2() {
        test.startTest();
        VerifyDate.CheckDates(system.today()+2, system.today());
        test.stopTest();
    }
}