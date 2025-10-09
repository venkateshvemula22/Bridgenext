import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { NavigationMixin } from "lightning/navigation";

export default class CreateAccountUi extends NavigationMixin(LightningElement) {
  isSubmitting = false;

  handleSubmit(event) {
    event.preventDefault();
    this.isSubmitting = true;
    const fields = event.detail.fields;
    this.template.querySelector("lightning-record-edit-form").submit(fields);
  }

  handleSuccess(event) {
    this.isSubmitting = false;
    const recordId = event.detail.id;

    this.dispatchEvent(
      new ShowToastEvent({
        title: "Success",
        message: "Account created successfully.",
        variant: "success"
      })
    );

    this.navigateToRecord(recordId);
    this.template.querySelector("lightning-record-edit-form").reset();
  }

  handleError(event) {
    this.isSubmitting = false;

    this.dispatchEvent(
      new ShowToastEvent({
        title: "Error creating account",
        message:
          event?.detail?.message ||
          "Review the errors on the form and try again.",
        variant: "error"
      })
    );
  }

  navigateToRecord(recordId) {
    if (!recordId) {
      return;
    }

    this[NavigationMixin.Navigate]({
      type: "standard__recordPage",
      attributes: {
        recordId,
        objectApiName: "Account",
        actionName: "view"
      }
    });
  }
}
