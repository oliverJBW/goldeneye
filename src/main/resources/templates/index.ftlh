<!DOCTYPE html>  
<html lang="en">  
    <head>
        <meta charset="UTF-8">
        <title>Gener</title>
        <link rel="stylesheet" href="/webjars/bootstrap/5.0.0/css/bootstrap.min.css">
        <script src="/webjars/bootstrap/5.0.0/js/bootstrap.min.js"></script>
        <style>
            #errorMessage {
                background-color: #FFCCCC;
                color: #FF0000;
                padding: 10px;
                border: 1px solid #FF0000;
            }
          </style>
    </head>
    <body>
        <div class="container">
            <div class="row mt-3">
                <div class="col-md-12">
                    <div class="well well-sm">
                        <form class="form-horizontal" id="emailForm">
                            <fieldset>
                                <legend class="header col-md-4 text-center">Employees Email Adress Generator</legend>
                                <div class="form-group">
                                    <div class="col-md-4">
                                        <input id="name" title="Enter only letters (no numbers, accents or special characters)" name="name" pattern="^[A-Za-z\s]+$" type="text" required placeholder="Employee Name" class="form-control">
                                    </div>
                                </div>
                                <br>

                                <div class="form-group">
                                    <div class="col-md-4">
                                        <input id="surname" name="surname" title="Enter only letters (no numbers, accents or special characters)" pattern="^[A-Za-z\s]+$" type="text" required placeholder="Employee Surname" class="form-control">
                                    </div>
                                </div>
                                <br>

                                <div class="form-group">
                                    <div class="col-md-4">
                                        <select class="form-control" id="office" name="office" required>
                                            <option selected hidden disabled value="">Select an Office Location</option>
                                            <option value="milan">Milan</option>
                                            <option value="spain">Spain</option>
                                            <option value="newyork">New York</option>
                                        </select>                    
                                    </div>

                                    <div class="col-md-4 d-none" id="hideSelect">
                                        <br>
                                        <select class="form-control" id="department" name="department" required disabled>
                                            <option selected hidden disabled value="">Select a Department</option>
                                        </select>                   
                                    </div>
                                </div>
                                <br>
                                
                                <div class="form-group">
                                    <div class="col-md-4 text-center">
                                        <button type="submit" class="btn btn-primary btn-md">Generate</button>
                                    </div>
                                </div>
                                <br>
                                <div id="generatedEmail" class="col-md-4 text-center">

                                </div>
                                <div id="errorMessage" class="col-md-4 d-none">

                                </div>

                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script>
            let officeSelect = document.getElementById("office");
            let departmentSelect = document.getElementById("department");
            let departmentSelectHide = document.getElementById("hideSelect");

            officeSelect.addEventListener("change", function() {

                departmentSelectHide.classList.remove('d-none');
                let selectedOffice = officeSelect.value;

                departmentSelect.innerHTML = "";

                let option1 = document.createElement("option");
                option1.value = "design";
                option1.text = "Design";

                let option2 = document.createElement("option");
                option2.value = "business";
                option2.text = "Business";

                let option3 = document.createElement("option");
                option3.value = "advertising";
                option3.text = "Advertising";

                let option4 = document.createElement("option");
                option4.value = "research&development";
                option4.text = "Research & development";
                
                switch (selectedOffice) {
                    case "milan":
                        departmentSelect.add(option1);
                        departmentSelect.add(option2);
                        departmentSelect.add(option3);
                        break;
                    case "spain":
                        departmentSelect.add(option4);
                        departmentSelect.add(option2);
                        break;
                    case "newyork":
                        departmentSelect.add(option2);
                        departmentSelect.add(option3);
                        break;
                    default:
                        break;
                }

                departmentSelect.disabled = false;
            });

            document.addEventListener("DOMContentLoaded", function() {
              document.getElementById("emailForm").addEventListener("submit", function(event) {
                event.preventDefault(); 
          
                let xhr = new XMLHttpRequest();
          
                xhr.open("POST", "/generate", true);
          
                xhr.onload = function() {
                    let errorDiv = document.getElementById("errorMessage");
                    let emailDiv = document.getElementById("generatedEmail");
                    if (xhr.status === 200) {
                        errorDiv.classList.add('d-none');
                        emailDiv.innerHTML = xhr.responseText.toLowerCase();
                    } else {
                        emailDiv.innerHTML = "";
                        errorDiv.classList.remove('d-none');
                        errorDiv.innerHTML = "Error: " + xhr.status;
                    }
                };
          
                xhr.send(new FormData(this));
              });
            });
          </script>
          
    </body>
</html> 