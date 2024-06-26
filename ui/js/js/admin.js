var majorAPI = 'http://localhost:8081/admin/chuyennganh';
var courseAPI = 'http://localhost:8081/admin/monhoc';
var addCourseAPI = 'http://localhost:8081/admin/monhoc';
var lopHPAPI = 'http://localhost:8081/admin/monhoc/lophocphan';
var instructorAPI = 'http://localhost:8081/admin/giangvien';
var maLHPAPI = 'http://localhost:8081/admin/monhoc/lophocphan/malophocphan';
var tenLHPAPI = 'http://localhost:8081/admin/monhoc/lophocphan/tenlophocphan';
var maCourseAPI = 'http://localhost:8081/admin/monhoc/lophocphan/mamonhoc';
var addClassAPI = 'http://localhost:8081/admin/monhoc/themlophocphan';
var detailClassAPI = 'http://localhost:8081/dangkyhocphan/lophocphan/chitietlophocphan?enrollmentID=';
var statusClassAPI = 'http://localhost:8081/admin/monhoc/lophocphan/capnhattrangthai';
var deleteClassAPI = 'http://localhost:8081/admin/monhoc/lophocphan/xoalophocphan'

// xử lý sự kiện khi chọn checkbox tiên quyết
var checkbox = document.getElementById('tienQuyet');
var inputDiv = document.getElementById('tienQuyetInputDiv');
var prerequisite_global= '';
checkbox.addEventListener('change', function() {
    if (this.checked) {
        inputDiv.style.display = 'block';
        console.log(prerequisite_global);
    } else {
        inputDiv.style.display = 'none';
        prerequisite_global = '';
    }
});

// load năm học kì vào thẻ select
var year = new Date().getFullYear();
var semester = new Date().getMonth() < 6 ? 1 : 2;
var yearSemester = document.getElementById('semester');
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

// load năm học kì vào thẻ select trong modal thêm lớp học phần
var yearSemesterDK = document.getElementById('semesterDK');
console.log(yearSemesterDK);
for (var i = year; i >= year; i--) {
    var option = document.createElement('option');
    option.value = i + '-3';
    option.text = 'HK3 (' + i + '-' + (i + 1) + ')';
    yearSemesterDK.appendChild(option);

    var option = document.createElement('option');
    option.value = i + '-2';
    option.text = 'HK2 (' + i + '-' + (i + 1) + ')';
    yearSemesterDK.appendChild(option);

    var option = document.createElement('option');
    option.value = i + '-1';
    option.text = 'HK1 (' + i + '-' + (i + 1) + ')';
    yearSemesterDK.appendChild(option);
}

var courseID_current;
var courseName_current;
// load dữ liệu môn học vào bảng
function loadCourse(majorID) {
    fetch(courseAPI + '?majorID=' + majorID)
    .then(response => response.json())
    .then(courses => {
        
        var table = document.querySelector('#tb-course');
        var tbody = table.querySelector('tbody');

        tbody.innerHTML = '';
        courses.forEach((course, index) => {

            const row = tbody.insertRow();
            row.insertCell(0).textContent = index + 1; 
            row.insertCell(1).textContent = course.courseID;
            row.insertCell(2).textContent = course.name;
            row.insertCell(3).textContent = course.credits;
            row.insertCell(4).textContent = course.type;
            row.insertCell(5).textContent = course.prerequisites;

            row.addEventListener('click', function()  {
                var prevActiveRow = document.querySelector('tr.active');
                if (prevActiveRow) {
                    prevActiveRow.classList.remove('active');
                }
                this.classList.add('active');
                courseID_current = course.courseID;
                courseName_current = course.name;
                choiceCourse(courseID_current, courseName_current);
                var tableDetail = document.querySelector('#tb-detail tbody');
                tableDetail.innerHTML = '';
                clearModalLHP();
            });
        });
    })
    .catch(error => console.error('Error:', error));
}

// chọn môn học và hiển thị danh sách lớp học phần
function choiceCourse(courseID, courseName) {
    year = document.getElementById('semester').value.slice(0, 4);
    console.log(year)
    semester = document.getElementById('semester').value.slice(5);
    console.log(semester)
    console.log(lopHPAPI + '?courseID=' + courseID + '&semester=' + semester + '&year=' + year)
    fetch(lopHPAPI + '?courseID=' + courseID + '&semester=' + semester + '&year=' + year)
    .then(function(response) {
        return response.json();
    })
    .then(function(classes) {
        console.log(classes);
        var table = document.querySelector('#tb-class');
        var tbody = table.querySelector('tbody');
        tbody.innerHTML = '';

        classes.forEach((lop, index) => {
            const row = tbody.insertRow();
            row.insertCell(0).textContent = index + 1; 
            row.insertCell(1).textContent = lop.enrollmentID;
            row.insertCell(2).textContent = courseName;
            row.insertCell(3).textContent = lop.name;
            row.insertCell(4).textContent = lop.quantity;
            row.insertCell(5).textContent = lop.quantityApply;
            row.insertCell(6).textContent = lop.status;

            const buttonCell = row.insertCell(7);
            const button = document.createElement('button');
            button.classList.add('btn', 'btn-danger');
            button.textContent = 'Xóa';
            buttonCell.appendChild(button);
            button.onclick = () => deleteClass(lop.enrollmentID);

            row.addEventListener('click', function() {
                var prevActiveRow = table.querySelector('.active');
                if (prevActiveRow) {
                    prevActiveRow.classList.remove('active');
                }
                this.classList.add('active');
                choiceClass(lop.enrollmentID);
                
            });
        });
    })
}

// lấy danh sách môn học theo học kỳ
var choiceSemester = document.getElementById("semester");
choiceSemester.addEventListener("change", function() {
    console.log(courseID_current)
    choiceCourse(courseID_current, courseName_current);
});

var choiceMajor = document.getElementById('major');
choiceMajor.addEventListener('change', function() {
    console.log(choiceMajor.value);
    loadCourse(choiceMajor.value);
    loadInstructor(choiceMajor.value);
});

// valid course
function validCourse() {
    var courseID = document.getElementById('courseID').value;
    var courseName = document.getElementById('courseName').value;
    var credits = document.getElementById('credits').value;
    var type = document.getElementById('type').value;
    var majorID = document.getElementById('major').value;

    if (majorID == '') {
        alert('Vui lòng chọn chuyên ngành');
        return false;
    }
    if (courseID == '' || courseName == '' || credits == '' || type == '') {
        alert('Vui lòng nhập đầy đủ thông tin');
        return false;
    }
    return true;
}

// taọ mã môn học
function taoMaCourse() {
    fetch(maCourseAPI)
    .then(response => response.json())
    .then(data => {
        var maMon = document.getElementById('courseID');
        maMon.value = data.result;
    })
}

// thêm môn học với chuyên ngành đươc chọn
function addCourse() {
    if (!validCourse()) {
        return;
    }
    if (document.getElementById('tienQuyet').checked) {
        prerequisite_global = document.getElementById('tienQuyetMaMonHoc').value;
    }

    var courseID = document.getElementById('courseID').value;
    var courseName = document.getElementById('courseName').value;
    var credits = document.getElementById('credits').value;
    var type = document.getElementById('type').value;
    var prerequisite = prerequisite_global;
    var majorID = document.getElementById('major').value;

    var course = {
        courseID: courseID,
        name: courseName,
        credits: credits,
        type: type,
        prerequisites: prerequisite,
        majorsID: majorID
    };

    console.log(course);

    fetch(addCourseAPI, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(course)
    })
    .then(response => {
        response.json().then(data => {
            alert(data.result);
        });
        $('#myModal').modal('hide');
        loadCourse(majorID);
        document.getElementById('courseID').value = "";
        document.getElementById('courseName').value = "";
        document.getElementById('credits').value = "";
        document.getElementById('type').value = "";
        prerequisite_global = "";
        document.getElementById('major').value   = "";
    })
}

// load dữ liệu chuyên ngành vào thẻ select
function loadMajor() {
    var selectElement = document.getElementById('major');
    fetch(majorAPI)
    .then(response => response.json())
    .then(data => {
        data.forEach(item => {
            var option = document.createElement('option');
            option.value = item.majorID;
            option.text = item.name;

            selectElement.appendChild(option);
        });
    })
    .catch(error => console.error('Error:', error));
}
loadMajor();

// xử lý sự kiện khi chọn checkbox thực hành
var checkboxTH = document.getElementById('thuchanh');
var inputDivTH1 = document.getElementById('hienThi1');
var inputDivTH2 = document.getElementById('hienThi2');
var inputDivTH3 = document.getElementById('hienThi3');
var inputDivTH4 = document.getElementById('hienThi4');
var inputDivTH5 = document.getElementById('hienThi5');
var inputDivTH6 = document.getElementById('hienThi6');
var inputDivTH7 = document.getElementById('hienThi7');
var inputDivTH8 = document.getElementById('hienThi8');
var inputDivTH9 = document.getElementById('hienThi9');
var inputDivTH10 = document.getElementById('hienThi10');
var inputDivTH11 = document.getElementById('hienThi11');
var inputDivTH12 = document.getElementById('hienThi12');
checkboxTH.addEventListener('change', function() {
    if (this.checked) {
        inputDivTH1.style.display = 'block';
        inputDivTH2.style.display = 'block';
        inputDivTH3.style.display = 'block';
        inputDivTH4.style.display = 'block';
        inputDivTH5.style.display = 'block';
        inputDivTH6.style.display = 'block';
        inputDivTH7.style.display = 'block';
        inputDivTH8.style.display = 'block';
        inputDivTH9.style.display = 'block';
        inputDivTH10.style.display = 'block';
        inputDivTH11.style.display = 'block';
        inputDivTH12.style.display = 'block';
    } else {
        inputDivTH1.style.display = 'none';
        inputDivTH2.style.display = 'none';
        inputDivTH3.style.display = 'none';
        inputDivTH4.style.display = 'none';
        inputDivTH5.style.display = 'none';
        inputDivTH6.style.display = 'none';
        inputDivTH7.style.display = 'none';
        inputDivTH8.style.display = 'none';
        inputDivTH9.style.display = 'none';
        inputDivTH10.style.display = 'none';
        inputDivTH11.style.display = 'none';
        inputDivTH12.style.display = 'none';
    }
});

// load dữ liệu giảng viên vào thẻ select
function loadInstructor(choiceMajor) {
    var selectElement = document.getElementById('instructor');
    var selectElementTH = document.getElementById('instructorTH');
    fetch(instructorAPI + '?majorID=' + choiceMajor)
    .then(response => response.json())
    .then(data => {
        data.forEach(item => {
            var option = document.createElement('option');
            option.value = item.id;
            option.text = item.name;

            selectElement.appendChild(option);
            selectElementTH.appendChild(option.cloneNode(true));
        });
    })
    .catch(error => console.error('Error:', error));
}

function dieuKienTaoMaVaTenLHP() {
    var majorID = document.getElementById('major').value;
    if (majorID == '') {
        alert('Vui lòng chọn chuyên ngành');
        return false;
    }
    var activeCourse = document.querySelector('#tb-course tr.active');
    if (!activeCourse) {
        alert('Vui lòng chọn môn học cần tạo lớp học phần');
        return false;
    }
    return true;
}

// taọ mã lớp học phần
function taoMaLHP() {
    if (dieuKienTaoMaVaTenLHP()) {
        fetch(maLHPAPI + '?courseID=' + courseID_current)
        .then(response => response.json())
        .then(data => {
            var maLHP = document.getElementById('enrollmentID');
            maLHP.value = data.result;
        })
    } 
}

// taọ tên lớp học phần
function taoTenLHP() {
    if (dieuKienTaoMaVaTenLHP()) {
        fetch(tenLHPAPI + '?majorID=' + choiceMajor.value)
        .then(response => response.json())
        .then(data => {
            var tenLHP = document.getElementById('name');
            tenLHP.value = data.result;
        })
    }
}

// valid lịch học
function validAddScheduleStudy() {
    var thu = document.getElementById('thu').value;
    var tietBD = document.getElementById('tietBatDau').value;
    var tietKT = document.getElementById('tietKetThuc').value;

    if (thu == '' || tietBD == '' || tietKT == '') {
        alert('Vui lòng nhập đầy đủ thông tin của lịch học lý thuyết');
        return false;
    }
    return true;
}

// thêm lịch học
var schedule = [];
function addScheduleStudy() {
    if (!validAddScheduleStudy()) {
        return;
    }
    var thu = document.getElementById('thu').value;
    var tietBD = document.getElementById('tietBatDau').value;
    var tietKT = document.getElementById('tietKetThuc').value;

    var scheduleStudy = {
        dayOfWeek: thu,
        classesStart: tietBD,
        classesEnd: tietKT
    }
    schedule.push(scheduleStudy);
    console.log(schedule);
    var textSchedule = ""
    schedule.forEach((item,index) => {
        if (index > 0){
            textSchedule += ', ';
        
        }
        textSchedule +="Thứ " +item.dayOfWeek + ' Tiết ' + item.classesStart + '-' + item.classesEnd ;
    });
    document.getElementById('scheduleStudy').value = textSchedule;
}

// valid lịch thực hành
function validAddPractice() {
    var phong = document.getElementById('phongTH').value;
    var quantity = document.getElementById('siSoTH').value;
    var instructorTH = document.getElementById('instructorTH').value;
    var thu = document.getElementById('thuTH').value;
    var tietBD = document.getElementById('tietBatDauTH').value;
    var tietKT = document.getElementById('tietKetThucTH').value;

    if (phong == '' || quantity == '' || instructorTH == '' || thu == '' || tietBD == '' || tietKT == '') {
        alert('Vui lòng nhập đầy đủ thông tin của lớp học thực hành');
        return false;
    }
    return true;
}

// thêm lớp thực hành
var lopTH = [];
function addPractice() {
    if (!validAddPractice()) {
        return;
    }
    var phong = document.getElementById('phongTH').value;
    var quantity = document.getElementById('siSoTH').value;
    var instructorTH = document.getElementById('instructorTH').value;
    var thu = document.getElementById('thuTH').value;
    var tietBD = document.getElementById('tietBatDauTH').value;
    var tietKT = document.getElementById('tietKetThucTH').value;

    var scheduleStudy = {
        dayOfWeek: thu,
        classesStart: tietBD,
        classesEnd: tietKT
    }
    var enrollmentPs = {
        room: phong,
        quantity: quantity,
        instructorID: instructorTH,
        scheduleStudy: scheduleStudy
    }

    lopTH.push(enrollmentPs);
    console.log(lopTH);

    var textLopTH = "";
    lopTH.forEach((item,index) => {
        if (index > 0) {
            textLopTH += ', ';
        
        }
        textLopTH += "Phòng: " + item.room + ' Sĩ số: ' + item.quantity + ' GV: ' + item.instructorID + ' Thứ: ' + item.scheduleStudy.dayOfWeek + ' Tiết ' + item.scheduleStudy.classesStart + '-' + item.scheduleStudy.classesEnd;
    });
    document.getElementById('practice').value = textLopTH;
}

// valid thêm lớp học phần
function validAddLHP() {
    var enrollmentID = document.getElementById('enrollmentID').value;
    var name = document.getElementById('name').value;
    var year = document.getElementById('year').value;
    var quantity = document.getElementById('quantity').value;
    var roomName = document.getElementById('roomName').value;
    var instructor = document.getElementById('instructor').value;
    var status = document.getElementById('status').value;
    var dateStart = document.getElementById('nam').value + '-' + document.getElementById('thang').value + '-' + document.getElementById('ngay').value;
    var dateApplyStart = document.getElementById('nam1').value + '-' + document.getElementById('thang1').value + '-' + document.getElementById('ngay1').value;
    var dateApplyEnd = document.getElementById('nam2').value + '-' + document.getElementById('thang2').value + '-' + document.getElementById('ngay2').value;
    
    if (enrollmentID == '' || name == '' || year == '' || quantity == '' || roomName == '' || instructor == '' || status == '' || dateStart == '' || dateApplyStart == '' || dateApplyEnd == '') {
        alert('Vui lòng nhập đầy đủ thông tin');
        return false;
    }
    
    if (schedule.length == 0) {
        alert('Vui lòng nhập lịch học lý thuyết');
        return false;
    }

    if (document.getElementById('thuchanh').checked && lopTH.length == 0) {
        alert('Vui lòng nhập lịch học thực hành');
        return false;
    }
    
    return true;
}

// thêm lớp học phần
function addLHP() {
    if (!validAddLHP()) {
        return;
    }
    var enrollmentID = document.getElementById('enrollmentID').value;
    var name = document.getElementById('name').value;
    var year = document.getElementById('year').value;
    var semester = document.getElementById('semesterDK').value.slice(5);
    var quantity = document.getElementById('quantity').value;
    var roomName = document.getElementById('roomName').value;
    var instructor = document.getElementById('instructor').value;
    var courseID = courseID_current;
    var status = document.getElementById('status').value;
    var dateStart = document.getElementById('nam').value + '-' + document.getElementById('thang').value + '-' + document.getElementById('ngay').value;
    var dateApplyStart = document.getElementById('nam1').value + '-' + document.getElementById('thang1').value + '-' + document.getElementById('ngay1').value;
    var dateApplyEnd = document.getElementById('nam2').value + '-' + document.getElementById('thang2').value + '-' + document.getElementById('ngay2').value;
    var scheduleStudy = schedule;
    if (document.getElementById('thuchanh').checked) {
        var enrollmentPs = lopTH;
    } else {
        var enrollmentPs = [];
    }

    var lopHP = {
        enrollmentID: enrollmentID,
        name: name,
        year: year,
        semester: semester,
        quantity: quantity,
        roomName: roomName,
        instructorID: instructor,
        courseID: courseID,
        status: status,
        dateStart: dateStart,
        dateApplyStart: dateApplyStart,
        dateApplyEnd: dateApplyEnd,
        scheduleStudy: scheduleStudy,
        enrollmentPs: enrollmentPs
    }

    console.log(lopHP);

    fetch(addClassAPI, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(lopHP)
    })
    .then(response => {
        response.json().then(data => {
            alert(data.result);
        });
        $('#themLHP').modal('hide');
        clearModalLHP();
        choiceCourse(courseID_current, courseName_current);
    })
}


// xóa thông tin của modal thêm lớp học phần
function clearModalLHP() {
    document.getElementById('enrollmentID').value = "";
    document.getElementById('name').value = "";
    document.getElementById('year').value = "";
    document.getElementById('quantity').value = "";
    document.getElementById('semesterDK').value = "";
    document.getElementById('roomName').value = "";
    document.getElementById('instructor').value = "";
    document.getElementById('status').value = "";
    document.getElementById('nam').value = "";
    document.getElementById('thang').value = "";
    document.getElementById('ngay').value = "";
    document.getElementById('nam1').value = "";
    document.getElementById('thang1').value = "";
    document.getElementById('ngay1').value = "";
    document.getElementById('nam2').value = "";
    document.getElementById('thang2').value = "";
    document.getElementById('ngay2').value = "";
    document.getElementById('scheduleStudy').value = "";
    document.getElementById('thu').value = "";
    document.getElementById('tietBatDau').value = "";
    document.getElementById('tietKetThuc').value = "";
    document.getElementById('practice').value = "";
    document.getElementById('thuTH').value = "";
    document.getElementById('tietBatDauTH').value = "";
    document.getElementById('tietKetThucTH').value = "";
    document.getElementById('phongTH').value = "";
    document.getElementById('siSoTH').value = "";
    document.getElementById('instructor').value = "";
    schedule = [];
    lopTH = [];
}

//  load chi tiết lớp học phần
function choiceClass(enrollmentID) {
    fetch(detailClassAPI + enrollmentID)
    .then(response => response.json())
    .then(detail => {
        console.log(detail);

        var table = document.querySelector('#tb-detail');
        var tbody = table.querySelector('tbody');
        tbody.innerHTML = '';

        for (var i = 0; i < detail.scheduleStudy.length; i++) {
            const row = tbody.insertRow();

            row.insertCell().textContent = i + 1;
            row.insertCell(1).textContent = 'LT - Thứ ' + detail.scheduleStudy[i].dayOfWeek + ' (T' + detail.scheduleStudy[i].classesStart + ' - T' + detail.scheduleStudy[i].classesEnd + ')';
            row.insertCell(2).textContent = "";
            row.insertCell(3).textContent = detail.roomName;
            row.insertCell(4).textContent = detail.nameInstuctor;
            row.insertCell(5).textContent = detail.dateStart;
        }

        for (var i = 0; i < detail.enrollmentPs.length; i++) {
            const row = tbody.insertRow();
            row.insertCell(0).textContent = i + 1 + detail.scheduleStudy.length;
            row.insertCell(1).textContent = 'TH - Thứ ' + detail.enrollmentPs[i].scheduleStudy.dayOfWeek + ' (T' + detail.enrollmentPs[i].scheduleStudy.classesStart + ' - T' + detail.enrollmentPs[i].scheduleStudy.classesEnd + ')';
            row.insertCell(2).textContent = detail.enrollmentPs[i].name;
            row.insertCell(3).textContent = detail.enrollmentPs[i].room;
            row.insertCell(4).textContent = detail.enrollmentPs[i].nameInstructor;
            row.insertCell(5).textContent = detail.dateStart;
        }
    })
}

// thay đổi trạng thái lớp học phần
function changeStatus(status) {
    var tableClass = document.getElementById('tb-class');
    var activeRow = tableClass.querySelector('.active');
    if (!activeRow) {
        alert('Vui lòng chọn lớp học phần cần thay đổi trạng thái');
        return;
    }
    var enrollmentID = activeRow.cells[1].textContent;
    var status = status;
    var data = {
        enrollmentID: enrollmentID,
        status: status
    }
    console.log(data);
    fetch(statusClassAPI, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    })
    .then(response => {
        return response.json();
    })
    .then(response => {
        alert(response.result);
        activeRow.cells[6].textContent = status;
        document.getElementById('statusLHP').value = "";
    })
}

var choiceStatus = document.getElementById('statusLHP');
choiceStatus.addEventListener('change', function() {
    changeStatus(choiceStatus.value);
});

function deleteClass(enrollmentID) {
    var enrollment = {
        "enrollmentID": enrollmentID
    }
    console.log(enrollment);

    fetch(deleteClassAPI, {
        method: "POST",
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(enrollment)
    })
        .then((res) => {
            return res.json();
        })
        .then((response) => {
            alert(response.result);
            var table = document.querySelector('#tb-class');
            var tbody = table.querySelector('tbody');
            tbody.innerHTML = '';
            var table = document.querySelector('#tb-detail');
            var tbody = table.querySelector('tbody');
            tbody.innerHTML = '';
            choiceCourse(courseID_current, courseName_current);
        })
}