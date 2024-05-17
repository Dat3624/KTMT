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

        console.log(data[0].semester);
        const row = tbody.insertRow();
        let hk = `<tr>
            <td colspan="19" class="text-left row-head bold">HK2 (2021-2022)</td>
            </tr>`
        row.innerHTML = hk;

        data.forEach((element, index) => {
            if(element.semester == 2 && element.year == 2024) {
                var overallScore = element.overallScore;
                var diemChu;
                if(overallScore >= 9) {
                    diemChu = 'A';
                } else if(overallScore >= 8) {
                    diemChu = 'B';
                } else if(overallScore >= 6.5) {
                    diemChu = 'C';
                } else if(overallScore >= 5) {
                    diemChu = 'D';
                } else {
                    diemChu = 'F';
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
                    <td>thang 4</td>
                    <td>${diemChu}</td>
                    <td>loai</td>
                    <td>dat</td>
                `
                row.innerHTML = diem;
            }
        });
    });
}
result();