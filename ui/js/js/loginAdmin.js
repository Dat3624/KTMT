var accountAdminAPI = 'http://localhost:8081/accountAdmin';

function login(){
    event.preventDefault();
    var username = document.getElementById("UserName").value;
    var pw = document.getElementById("Password").value; 
    
    if(username == "" || pw == ""){
        return;
    } else {
        fetch(accountAdminAPI + '/' + username)
        .then(function(response){
            return response.json();
        })
        .then(function(account){
            console.log(account);
            if(account == null){
                alert("Tài khoản không tồn tại")
            } else if(username == account.username && pw == account.password){
                localStorage.setItem('studentID',username);
                window.location.href="../html/admin.html"
            } else if(username != account.username || pw != account.password){
                alert("Tên hoặc mật khẩu không chính xác")
            }
        })
        .catch(function(err){
            console.log(err);
        });
    }
}