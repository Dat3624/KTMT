var accountNormalAPI = 'http://localhost:8081/accountNormal';

function login(){
    event.preventDefault();
    var username = document.getElementById("UserName").value;
    var pw = document.getElementById("Password").value; 
    
    if(username == "" || pw == ""){
        return;
    } else {
        fetch(accountNormalAPI + '/' + username)
        .then(function(response){
            // return response.json();
            if (!response.ok) {
                throw new Error('Network response was not ok ' + response.statusText);
            }
            return response.text();
        })
        .then(function(account){
            console.log(account);
            if(account == null){
                alert("Tài khoản không tồn tại")
            } else if(username == account.username && pw == account.password){
                localStorage.setItem('studentID',username);
                window.location.href="../html/dashboard.html"
            } else if(username != account.username || pw != account.password){
                alert("Tên hoặc mật khẩu không chính xác")
            }
        })
        .catch(function(err){
            console.log(err);
        });
    }
}