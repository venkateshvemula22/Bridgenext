import { LightningElement, wire, api, track } from 'lwc';
import GetStudentList from '@salesforce/apex/StudentListController.GetStudentList';
import { refreshApex } from '@salesforce/apex';
import { updateRecord } from 'lightning/uiRecordApi';
import { getObjectinfo } from 'lightning/uiObjectInfoApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import COURSE from '@salesforce/schema/Course__c';
import ROLL_NUMBER from '@salesforce/schema/student__c.Roll_Number_del__c';
import STUDENT_NAME from '@salesforce/schema/student__c.Name';
import STUDENT_PHONE from '@salesforce/schema/student__c.student_phone__c';
import STUDENT_EMAIL from '@salesforce/schema/student__c.student_email__c';
import STUDENT_COUNTRY from '@salesforce/schema/student__c.Country__c';
import STUDENT_COURSE from '@salesforce/schema/student__c.Course__r.Name';
import RECORD_TYPE from '@salesforce/schema/student__c.RecordTypeId';

const COLS = [
    {
        label: 'Roll Number',
        fieldName: ROLL_NUMBER.fieldApiName,
    },
    {
        label: 'Student Name',
        fieldName: STUDENT_NAME.fieldApiName,
        editable: true
    },
    { label: 'Phone',
     fieldName: STUDENT_PHONE.fieldApiName,
     type: 'Phone',
      editable: true 
    },
    {
        label: 'Email',
        fieldName: STUDENT_EMAIL.fieldApiName,
        type: 'email',
        editable: true
    },
    {
        label: 'Country',
        fieldName: STUDENT_COUNTRY.fieldApiName,
        editable: true
    },
    {
        label: 'Course',
        fieldName: STUDENT_COURSE.fieldApiName
    },
    {
        label: 'Record Type',
        fieldName: RECORD_TYPE.fieldApiName
    }
];

export default class StudentListComponent extends LightningElement {
    columns = COLS;
    @track error;
    @track stdList ;
    @api objectName;
    @api soqlQuery;
 
    @wire(GetStudentList, {objectName: '$objectName', soqlQuery: '$soqlQuery'})
    wiredStudents({
        error,
        data
    }) {
        if (data) {
            this.stdList = data;
        } else if (error) {
            this.error = error;
        }
    }

    async handlesave( event ){
        const updatedFields = event.details.draftValues;

        await savearecords ( { data: updatedFields} )
        .then( result => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'student record(s) are updated',
                    variant: 'Success'

                })
            );
            refreshApex(this.wiredStudents).then (() =>{

            })
        })
    }
}