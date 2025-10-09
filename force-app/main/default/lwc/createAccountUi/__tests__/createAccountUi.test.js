jest.mock("lightning/platformShowToastEvent", () => {
  const ShowToastEventName = "lightning__showtoast";
  class ShowToastEvent extends CustomEvent {
    constructor(detail) {
      super(ShowToastEventName, { detail, bubbles: true, composed: true });
    }
  }

  return { ShowToastEventName, ShowToastEvent };
});

import { createElement } from "lwc";
import CreateAccountUi from "c/createAccountUi";
import { ShowToastEventName } from "lightning/platformShowToastEvent";

const mockNavigate = jest.fn();

/* eslint-disable no-shadow */
jest.mock("lightning/navigation", () => {
  const navSymbol = Symbol("navigate");

  const MockNavigationMixin = (Base) =>
    class extends Base {
      [navSymbol](pageReference) {
        mockNavigate(pageReference);
      }
    };

  MockNavigationMixin.Navigate = navSymbol;
  return { NavigationMixin: MockNavigationMixin };
});

function flushPromises() {
  return Promise.resolve().then(() => Promise.resolve());
}

describe("c-create-account-ui", () => {
  afterEach(() => {
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
    mockNavigate.mockReset();
    jest.clearAllMocks();
  });

  it("sets submitting state and shows spinner on submit", async () => {
    const element = createElement("c-create-account-ui", {
      is: CreateAccountUi
    });
    document.body.appendChild(element);

    const form = element.shadowRoot.querySelector("lightning-record-edit-form");
    form.submit = jest.fn();

    form.dispatchEvent(
      new CustomEvent("submit", {
        cancelable: true,
        detail: { fields: { Name: "Test Account" } }
      })
    );
    await flushPromises();

    expect(form.submit).toHaveBeenCalledWith({ Name: "Test Account" });
    expect(
      element.shadowRoot.querySelector("lightning-spinner")
    ).not.toBeNull();
  });

  it("handles successful account creation", async () => {
    const element = createElement("c-create-account-ui", {
      is: CreateAccountUi
    });
    document.body.appendChild(element);

    const form = element.shadowRoot.querySelector("lightning-record-edit-form");
    form.submit = jest.fn();
    form.reset = jest.fn();
    const toastHandler = jest.fn();
    element.addEventListener(ShowToastEventName, toastHandler);

    form.dispatchEvent(
      new CustomEvent("submit", {
        cancelable: true,
        detail: { fields: { Name: "Acme" } }
      })
    );
    await flushPromises();

    form.dispatchEvent(
      new CustomEvent("success", {
        detail: { id: "001000000000001" }
      })
    );
    await flushPromises();

    expect(element.shadowRoot.querySelector("lightning-spinner")).toBeNull();
    expect(mockNavigate).toHaveBeenCalledWith(
      expect.objectContaining({
        type: "standard__recordPage",
        attributes: expect.objectContaining({
          recordId: "001000000000001",
          objectApiName: "Account",
          actionName: "view"
        })
      })
    );
    expect(form.reset).toHaveBeenCalled();
    expect(toastHandler).toHaveBeenCalledTimes(1);
    expect(toastHandler.mock.calls[0][0].detail.variant).toBe("success");
  });

  it("surfaces error toast on failure", async () => {
    const element = createElement("c-create-account-ui", {
      is: CreateAccountUi
    });
    document.body.appendChild(element);

    const form = element.shadowRoot.querySelector("lightning-record-edit-form");
    form.submit = jest.fn();
    const toastHandler = jest.fn();
    element.addEventListener(ShowToastEventName, toastHandler);

    form.dispatchEvent(
      new CustomEvent("submit", {
        cancelable: true,
        detail: { fields: { Name: "Error Account" } }
      })
    );
    await flushPromises();

    form.dispatchEvent(
      new CustomEvent("error", {
        detail: { message: "Custom error message" }
      })
    );
    await flushPromises();

    expect(element.shadowRoot.querySelector("lightning-spinner")).toBeNull();
    expect(toastHandler).toHaveBeenCalledTimes(1);
    expect(toastHandler.mock.calls[0][0].detail.variant).toBe("error");
    expect(toastHandler.mock.calls[0][0].detail.message).toBe(
      "Custom error message"
    );
  });
});
/* eslint-enable no-shadow */
