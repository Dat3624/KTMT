var resultAPI = "http://localhost:8081/sinhvien/result/";

var studentID = localStorage.getItem("studentID");

function result(){
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
        for (var i = year; i > year - 3; i--) {
            var option = document.createElement('option');
            option.value = i + '-3';
            option.text = 'HK3 (' + i + '-' + (i + 1) + ')';
            yearSemester.appendChild(option);
        
            var option = document.createElement('option');
            option.value = i + '-2';
            option.text = 'HK2 (' + i + '-' + (i + 1) + ')';
            yearSemester.appendChild(option);
        
            var option = document.createElement('option');
            option.value = i + '-1';
            option.text = 'HK1 (' + i + '-' + (i + 1) + ')';
            yearSemester.appendChild(option);
        }
        const row = tbody.insertRow();
        let hk = `<tr>
            <td colspan="19" class="text-left row-head bold">HK2 (2021-2022)</td>
            </tr>`
        row.innerHTML = hk;

        data.forEach((element, index) => {
            if(element.semester == 2 && element.year == 2024) {
                var overallScore = element.overallScore;
                var diemChu;
                var diemBon;
                var loai;
                var dat;
                if(overallScore >= 8.5) {
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

                const row = tbody.insertRow();
                let diem = `
                    <td>${index + 1}</td>
                    <td>${element.enrollmentID}</td>
                    <td>${element.nameCourse}</td>
                    <td>${element.credit}</td>
                    <td>${element.midtermScore}</td>
                    <td></td>
                    <td>${element.regularScore[0]}</td>
                    <td>${element.regularScore[1]}</td>
                    <td>${element.regularScore[2]}</td>
                    <td>${element.practiceScore[0]}</td>
                    <td>${element.practiceScore[1]}</td>
                    <td>${element.practiceScore[2]}</td>
                    <td>${element.finalScore}</td>
                    <td>${element.overallScore}</td>
                    <td>${diemBon}</td>
                    <td>${diemChu}</td>
                    <td>${loai}</td>
                    <td>${dat}</td>
                `
                row.innerHTML = diem;
            }
        });
    });
}
result();