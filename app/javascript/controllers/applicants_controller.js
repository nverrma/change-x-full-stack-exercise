import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="applicants"
export default class extends Controller {
  static targets = ["selectField"];
  static values = {
    original: String,
  };
  connect() {
    this.showCommentField();
  }

  showCommentField() {
    let divElement = document.getElementById("status-comment");
    let inputElement = document.getElementById("applicant_comment_body");

    if (this.originalValue == this.selectFieldTarget.value) {
      divElement.style.display = "none";
      inputElement.required = false;
    } else {
      divElement.style.display = "block";
      inputElement.required = true;
    }
  }
}
