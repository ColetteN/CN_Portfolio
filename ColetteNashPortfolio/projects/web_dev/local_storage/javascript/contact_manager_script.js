//Contact Manager JavaScript; Colette Nash K00212038

//For the local storage I attached the storing of data to the addToArray button and the retrieval of data to the addToTable button, so the data can be extracted from the array

function deleteRowFunction(r)
		{
			var i = r.parentNode.parentNode.rowIndex;
			document.getElementById("newMemberTable").deleteRow(i);
			membersArray.splice(i, 1);
		}

var membersArray = new Array(); //create the array/object

window.onload = function()
{	
	if(typeof(window.localStorage)!='undefined')
            {
                if(localStorage.getItem('myObjectKey') != null)                
                {
                    membersArray=JSON.parse(localStorage.getItem("myObjectKey"));
                    createTable(); //converting to JSON format and print onto the table
                }
            }
	
	document.getElementById("addToArray").onclick = function()
	{
		var memberFN = document.getElementById("formFN").value; //grab form input values
		var memberLN = document.getElementById("formLN").value;
		var memberPaydate = document.getElementById("formPaydate").value;
		var memberAmtpaid = document.getElementById("formAmtpaid").value;
		var memberType = document.getElementById("theSelect").value;
		var deleterow = document.getElementById("deleterow").value;
		
		var newMember = new Object() //creating new object for newMember
		newMember.formFN = memberFN; //putting the property of formFN into memberFN
		newMember.formLN = memberLN;
		newMember.formPaydate = memberPaydate;
		newMember.formAmtpaid = memberAmtpaid;
		newMember.theSelect = memberType;
		newMember.deleterow = deleterow;
		
		var newMember = {"formFN":memberFN, "formLN":memberLN, "formPaydate":memberPaydate, "formAmtpaid":memberAmtpaid, "theSelect":memberType, "deleterow":deleterow} //putting the objects for local storage into the newMember
		
		membersArray.push(newMember); //push newMember into the array membersArray
		
		localStorage.setItem("myObjectKey", JSON.stringify(membersArray));
		//set the objects in the array for storage
		
	};
	//localStorage.clear();
		
		
	document.getElementById("addToTable").onclick = function () 
	//add the details onto the table with the onclick event
	
	{
		createTable();
	};

	document.getElementById("Hfirstname").onclick = function()
	{ //when you click on the heading first name sort
		membersArray.sort(sortFNames);
		function sortFNames(a, b) //sort alpha
		{
			var fnA = a.formFN.toLowerCase();
			var fnB = b.formFN.toLowerCase();

			if (fnA > fnB)	return -1;
			if (fnA < fnB)	return 1;
			else{
				return 0;
			}
		}
		
		createTable();
	};
	
	document.getElementById("Hlastname").onclick = function()
	{
		membersArray.sort(sortLNames);
		
		function sortLNames(a, b)
			{
				var lnA = a.formLN.toLowerCase();
				var lnB = b.formLN.toLowerCase();

				if (lnA > lnB) return -1;
				if (lnA < lnB) return 1;
				else{
					return 0;
				}
			}
		
		createTable();
	};
	
	document.getElementById("Hpaydate").onclick = function()
	{
		membersArray.sort(sortPayDate); //sort numerical
		
		function sortPayDate(a, b)
		{
			return a.formPaydate - b.formPaydate;
		}
		
		createTable();
	};
	
	document.getElementById("Hamtpaid").onclick = function() 
	{
		membersArray.sort(sortAmtPaid);
				
		function sortAmtPaid(a,b) //sort numerical
		{
			return a.formAmtpaid - b.formAmtpaid;
		}
	   	
	   	createTable();
				
	};
	
	document.getElementById("Htype").onclick = function()
	{
		membersArray.sort(sortType); //sort alpha
		
		function sortType(a,b)
		{
			var selTypeA = a.theSelect.toLowerCase();
			var selTypeB = b.theSelect.toLowerCase();
			
			if (selTypeA > selTypeB) return -1;
			if (selTypeA < selTypeB) return 1;
			else{
				return 0;
			}
		}
	};
	
	
	function createTable() //function to create a new table
	
	{
		var memberTable = document.getElementById("newMemberTable"); //create the table
		document.getElementById("newMemberTable").innerHTML=""; //clear the table before the next loop outside of the loop
		
		for (var i=0; i < membersArray.length; i++)	//loop over the array
			{
				var row = memberTable.insertRow(0) //new row
				var fnMember = row.insertCell(0); //new cell
				var lnMember = row.insertCell(1);
				var paydateMember = row.insertCell(2);
				var amtpaidMember = row.insertCell(3);
				var selectM = row.insertCell(4);
				var delMember = row.insertCell(5);
				fnMember.innerHTML = membersArray[i].formFN;
				lnMember.innerHTML = membersArray[i].formLN;
				paydateMember.innerHTML = membersArray[i].formPaydate;
				amtpaidMember.innerHTML = membersArray[i].formAmtpaid;
				selectM.innerHTML = membersArray[i].theSelect;
				delMember.innerHTML = '<button onclick="deleteRowFunction(this)" value="Delete">Delete Member</button>'; //dynamic button with the delete function attached
			}
	};

};
	


