var resultAPI = "http://localhost:8081/sinhvien/result/";
var studentAPI = 'http://localhost:8081/students';

var studentID = localStorage.getItem("studentID");

fetch(studentAPI + '/' + studentID)
    .then(function(response) {
        return response.json();
    })
    .then(function(student) {
        console.log(student);
        namNhapHoc = student.academicYear;
        document.getElementById('user-account-avatar').src = student.img;
        document.getElementById('user-account-name').textContent = student.name;
        result(namNhapHoc);
})

function result(namNhapHoc){
    fetch(resultAPI + studentID)
    .then(function(response) {
        return response.json();
    })
    .then(function(data) {
        console.log(data);
    
        var table = document.querySelector('#xemDiem');
        var tbody = table.querySelector('tbody');

        var year = new Date().getFullYear();
        var semester = new Date().getMonth() < 6 ? 1 : 2;
        for (var i = year - (year - namNhapHoc); i <= year; i++) {
            for (var j = 1; j <= 3; j++) {
                const row = tbody.insertRow();
                let hk = `<tr>
                    <td colspan="19" class="text-left row-head bold">HK${j} (${i}-${i+1})</td>
                    </tr>`;
                row.innerHTML = hk;
            }
        }
        
        data.forEach((element, index) => {
            var status = element.studyStatus;
            var overallScore = element.overallScore;
            var midtermScore = element.midtermScore;
            var finalScore = element.finalScore;
            // console.log(status);
            if(status != 'đã thi') {
                overallScore = '';
            }
            // if(element.semester == 2 && element.year == 2024) {
                var diemChu;
                var diemBon;
                var loai;
                var dat;
                if (overallScore == '') {
                    midtermScore = '';
                    finalScore = '';
                    diemChu = '';
                    diemBon = '';
                    loai = '';
                    dat = '';
                }
                else if(overallScore >= 8.5) {
                    diemChu = 'A';
                    diemBon = 4;
                    loai = 'Giỏi';
                    dat = 'Đạt';
                } else if(overallScore >= 7) {
                    diemChu = 'B';
                    diemBon = 3;
                    loai = 'Khá';
                    dat = 'Đạt';
                } else if(overallScore >= 5.5) {
                    diemChu = 'C';
                    diemBon = 2;
                    loai = 'Trung bình';
                    dat = 'Đạt';
                } else if(overallScore >= 4) {
                    diemChu = 'D';
                    diemBon = 1;
                    loai = 'Yếu';
                    dat = 'Đạt'
                } else {
                    diemChu = 'F';
                    diemBon = 0;
                    loai = 'Kém';
                    dat = 'Rớt môn'
                }
                if(element.regularScore.length==0){
                    for(var i = element.regularScore.length;i<3;i++){
                        element.regularScore[i]=""
                    }
                } else if(element.regularScore.length<2){
                    for(var i = element.regularScore.length;i<3;i++){
                        element.regularScore[i]=""
                    }
                } else {
                    for(var i = element.regularScore.length;i<3;i++){
                        element.regularScore[i]=""
                    }
                }

                if(element.practiceScore.length==0){
                    for(var i = element.practiceScore.length;i<3;i++){
                        element.practiceScore[i]=""
                    }
                } else if(element.practiceScore.length<2){
                    for(var i = element.practiceScore.length;i<3;i++){
                        element.practiceScore[i]=""
                    }
                } else {
                    for(var i = element.practiceScore.length;i<3;i++){
                        element.practiceScore[i]=""
                    }
                }
                
                var rows = tbody.getElementsByTagName('tr');
                for (var i = 0; i < rows.length; i++) {
                    if (rows[i].innerText.includes(`HK${element.semester} (${element.year}-${element.year + 1})`)) {
                        var newRow = tbody.insertRow(i + 1);
                        newRow.innerHTML = `
                            <td>${index + 1}</td>
                            <td>${element.enrollmentID}</td>
                            <td>${element.nameCourse}</td>
                            <td>${element.credit}</td>
                            <td>${midtermScore}</td>
                            <td></td>
                            <td>${element.regularScore[0]}</td>
                            <td>${element.regularScore[1]}</td>
                            <td>${element.regularScore[2]}</td>
                            <td>${element.practiceScore[0]}</td>
                            <td>${element.practiceScore[1]}</td>
                            <td>${element.practiceScore[2]}</td>
                            <td>${finalScore}</td>
                            <td>${overallScore}</td>
                            <td>${diemBon}</td>
                            <td>${diemChu}</td>
                            <td>${loai}</td>
                            <td>${dat}</td>
                        `
                        break;
                    }
                }
            // }
        });
    });
}
// result();