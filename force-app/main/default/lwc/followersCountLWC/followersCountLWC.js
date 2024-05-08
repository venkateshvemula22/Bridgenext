import { LightningElement, api, track, wire } from 'lwc';
import followUnfollowAccont from '@salesforce/apex/AccountFollowersCount.followUnfollowAccont';
import getFollowersCount from '@salesforce/apex/AccountFollowersCount.getFollowersCount';
import { refreshApex } from '@salesforce/apex';
import { subscribe, unsubscribe, onError, isEmpEnabled  } from 'lightning/empApi';


export default class FollowersCount extends LightningElement {
    @api recordId;
    @track isRunningUserFollowing =false;
    @track displyMsg;
    @track result;
    @track isFollowDisabled = false;
    @track isUnfollowDisabled = false;
    subscription = {};

    connectedCallback() {
        const messageCallback = (response) => {
            refreshApex(this.result);
        };

        subscribe('/event/AccountFollowEvent__e', -1, messageCallback).then(response => {
            this.subscription = response;
        });
    }

    @wire(getFollowersCount,{accountId : '$recordId'})
    FollowersCount(result){
        this.result = result;
        if(result.data){
            this.isRunningUserFollowing = result.data.isCurrentUserFollowing;
            let countOfFollowers = result.data.FollowersCount; 
            this.displyMsg = countOfFollowers == 1 ? `${countOfFollowers} other person is following this account` : `${countOfFollowers} other people are following this account`;
            this.isFollowDisabled = result.data.isCurrentUserFollowing;
            this.isUnfollowDisabled = !this.isFollowDisabled;
        }else if(result.error){
        console.error('Error fetching followers count:', result.error);
        }
    };
    
    handleFollowUnfollow(event) {
        const actionName = event.target.label;
        followUnfollowAccont({accountId : this.recordId, action : actionName})
                        .then((response) => {
                        this.isRunningUserFollowing = response.isCurrentUserFollowing;
                        let countOfFollowers = response.FollowersCount; 
                        this.displyMsg = countOfFollowers == 1 ? `${countOfFollowers} other person is following this account` : `${countOfFollowers} other people are following this account`;
                        this.isFollowDisabled = true;
                        this.isUnfollowDisabled = !this.isFollowDisabled;
                    }).catch((err) => {
                        console.error('Error fetching followers count:', err);
                        })
            
    }   
        
}