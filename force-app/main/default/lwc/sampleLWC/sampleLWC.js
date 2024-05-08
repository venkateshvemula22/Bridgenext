import { LightningElement } from 'lwc';

export default class SampleLWC extends LightningElement {
  
    finaltext = '';
    Name = 'venkatesh';
    SurName = 'vemula';
    Wife = 'akshaya';
    Mother = 'lalitha';
    Father = 'satyam';
    Son = 'reyaansh';
    FamilySize = 5;

    familydetails = [{

      'surname' : 'Vemula',
      'name' : 'Venkat',
      'wife' : 'Lahari',
      'son' : 'Reyaansh'

    },
    {
      
      'surname' : 'Jalagam',
      'name' : 'Ganesh',
      'wife' : 'Mamatha',
      'son' : 'Banni'

    },
    {
      
      'surname' : 'Sheelam',
      'name' : 'Yakanna',
      'wife' : 'Vijaya',
      'son' : 'Ranjith'

    }]
  

    constructor(){
      debugger
        super();
        this.MyFamilyDetails();    
      }

    MyFamilyDetails(){

        alert('Name = ' + this.Name + '\n' + 
            'SurName = ' + this.SurName + '\n' + 
            'Wife = ' + this.Wife + '\n' + 
            'Mother = ' + this.Mother + '\n' + 
            'Father = ' + this.Father + '\n' + 
            'Son = ' + this.Son + '\n' +
            'FamilySize = ' + this.FamilySize);
            
            this.family(this.Name,this.SurName,this.Wife,this.Mother,this.Father,this.Son,this.FamilySize);
    }

      family = (Name,SurName,Wife,Mother,Father,Son,fsize) => {

        alert(` Name = ${Name} \n SurName = ${SurName} \n Wife = ${Wife} \n FamilySize = $${fsize} `);

        alert('anonymous function executed.....!');
        return ` Name = ${Name} \n SurName = ${SurName} \n Wife = ${Wife} \n FamilySize = $${fsize} `
      }

      connectedCallback(){
        debugger
        this.Name = this.Name + ' ' +  this.SurName;
        console.log('Name == ' + this.Name);
        alert('connectedcallback....! ' + this.Name);


      }

      invokeJS = ()  => {
        debugger
     
        this.SurName= this.template.querySelectorAll('lightning-input')[0].value;

        console.log('Name == ' + this.Name);
        console.log('SurName == ' + this.SurName);
        console.log('Wife == ' + this.Wife);
        console.log('Son == ' + this.Son);
        console.log('Mother == ' + this.Mother);
        console.log('Father == ' + this.Father);
        console.log('FamilySize == ' + this.FamilySize);
        console.log('familydetails == ' + this.familydetails);

        alert('onclick of invokeJS............!')
      }

      invokeJS2(){

        debugger
        var myname = this.template.querySelectorAll('lightning-input');
        var fbtn = this.template.querySelector('[data-dataa="firstbutton"]').label;
        this.finaltext = fbtn;

        for (var i = 0; i < myname.length; i++) {

          var element = myname[i].value;
          this.finaltext = this.finaltext + ' ' + element;
          console.log('final text : ' + this.finaltext);
          alert(`final text is : ${this.finaltext}`);

        }
        return this.finaltext;
      }
}