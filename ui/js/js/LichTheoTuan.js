var scheduleAPI = 'http://localhost:8081/students/schedule/'

var studentID = localStorage.getItem('studentID');

// Cập nhật ngày hiện tại lên bảng
function updateDate() {
    var currentDate = new Date();
    var currentDay = currentDate.getDay();
    var days = ['Chủ nhật', 'Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7'];

    var firstDayOfWeek = new Date(currentDate.setDate(currentDate.getDate() - currentDay));

    for (var i = 1; i <= 7; i++) {
        var dayOfWeek = new Date(firstDayOfWeek);
        
        if(i == 7) {
            firstDay = dayOfWeek;
            console.log('fd ht ' + firstDay);
        }
        
        dayOfWeek.setDate(firstDayOfWeek.getDate() + i);
        
        // Định dạng ngày theo dạng 'dd/mm/yyyy'
        var formattedDate = dayOfWeek.getDate() + '/' + (dayOfWeek.getMonth() + 1) + '/' + dayOfWeek.getFullYear();

        document.querySelector('.fl-table th:nth-child(' + (i + 1) + ') span').textContent = days[i % 7] + ' (' + formattedDate + ')';

        if (i === 1) {
            document.getElementById('dateNgayXemLich').value = formattedDate;
        }
    }
}
updateDate();

var currentWeek = 0;
// Cập nhật ngày theo tuần
function changeWeek() {
    var currentDate = new Date();
    currentDate.setDate(currentDate.getDate() + (currentWeek * 7));

    var currentDay = currentDate.getDay();
    var days = ['Chủ nhật', 'Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7'];

    var firstDayOfWeek = new Date(currentDate.setDate(currentDate.getDate() - currentDay));

    for (var i = 1; i <= 7; i++) {
        var dayOfWeek = new Date(firstDayOfWeek);
        if(i == 7) {
            firstDay = dayOfWeek;
            console.log('fd cw ' + firstDay);
        }

        dayOfWeek.setDate(firstDayOfWeek.getDate() + i);

        var formattedDate = dayOfWeek.getDate() + '/' + (dayOfWeek.getMonth() + 1) + '/' + dayOfWeek.getFullYear();

        document.querySelector('.fl-table th:nth-child(' + (i + 1) + ') span').textContent = days[i % 7] + ' (' + formattedDate + ')';

        if (i === 1) {
            document.getElementById('dateNgayXemLich').value = formattedDate;
        }
    }
}

// Thêm sự kiện click cho các nút
document.getElementById('btn_HienTai').addEventListener('click', function() {
    currentWeek = 0;
    changeWeek();
    loadSchedule();
});

document.getElementById('btn_TroVe').addEventListener('click', function() {
    currentWeek--;
    changeWeek();
    loadSchedule();
});

document.getElementById('btn_Tiep').addEventListener('click', function() {
    currentWeek++;
    changeWeek();
    loadSchedule();
});

// load lịch học
function loadSchedule() {
    console.log('fd ' + firstDay);
    fetch(scheduleAPI + studentID)
    .then(function(response) {
        return response.json();
    })
    .then(function(data) {
        console.log(data);

        data.forEach(function(item) {
            startDate = new Date(item.startDate);
            endDate = new Date(item.endDate);

            var table = document.querySelector('.fl-table');
            var tbody = table.querySelector('tbody');
        
            // var numDate = parseInt(item.numDate);
            var schedules = item.schedules;
            
            const rows = tbody.querySelectorAll('tr');
            if(startDate <= firstDay && endDate >= firstDay) {
                console.log(startDate <= firstDay);

                schedules.forEach(schedule => {
                    const dayOfWeek = schedule.dayOfWeek;
                    const columnIndex = parseInt(dayOfWeek) - 1;
    
                    const tiet = schedule.classesStart + '-' + schedule.classesEnd;
                    
                    if(tiet == '1-3' || tiet == '4-6') {
                        const cells = rows[0].querySelectorAll('td');
                        if (cells.length > columnIndex) {
                            const cell = cells[columnIndex];
                            
                            let content = `<div class = "content color-lichhoc text-left"><b>${item.nameCourse}</b><br>`;
                            content += `${item.nameClass} - ${item.enrollmentID}<br>`;
                            content += `Tiết: ${schedule.classesStart} - ${schedule.classesEnd}<br>`;
                            content += `Phòng: ${item.roomName}<br>`;
                            content += `GV: ${item.nameInstructor}<br></div>`;
                            
                            cell.innerHTML = content;
                        }
                    } else if(tiet == '7-9' || tiet == '10-12') {
                        const cells = rows[1].querySelectorAll('td');
                        if (cells.length > columnIndex) {
                            const cell = cells[columnIndex];
                            
                            let content = `<div class = "content color-lichhoc text-left"><b>${item.nameCourse}</b><br>`;
                            content += `${item.nameClass} - ${item.enrollmentID}<br>`;
                            content += `Tiết: ${schedule.classesStart} - ${schedule.classesEnd}<br>`;
                            content += `Phòng: ${item.roomName}<br>`;
                            content += `GV: ${item.nameInstructor}<br></div>`;
                            
                            cell.innerHTML = content;
                        }
                    } else {
                        const cells = rows[3].querySelectorAll('td');
                        if (cells.length > columnIndex) {
                            const cell = cells[columnIndex];
                            
                            let content = `<div class = "content color-lichhoc text-left"><b>${item.nameCourse}</b><br>`;
                            content += `${item.nameClass} - ${item.enrollmentID}<br>`;
                            content += `Tiết: ${schedule.classesStart} - ${schedule.classesEnd}<br>`;
                            content += `Phòng: ${item.roomName}<br>`;
                            content += `GV: ${item.nameInstructor}<br></div>`;
                            
                            cell.innerHTML = content;
                        }
                    }
                });
            } else {
                schedules.forEach(schedule => {
                    const dayOfWeek = schedule.dayOfWeek;
                    const columnIndex = parseInt(dayOfWeek) - 1;
    
                    const tiet = schedule.classesStart + '-' + schedule.classesEnd;
                    
                    if(tiet == '1-3' || tiet == '4-6') {
                        const cells = rows[0].querySelectorAll('td');
                        if (cells.length > columnIndex) {
                            const cell = cells[columnIndex];
                            cell.innerHTML = '';
                        }
                    } else if(tiet == '7-9' || tiet == '10-12') {
                        const cells = rows[1].querySelectorAll('td');
                        if (cells.length > columnIndex) {
                            const cell = cells[columnIndex];
                            cell.innerHTML = '';
                        }
                    } else {
                        const cells = rows[3].querySelectorAll('td');
                        if (cells.length > columnIndex) {
                            const cell = cells[columnIndex];
                            cell.innerHTML = '';
                        }
                    }
                });
            }
            
        });
    })
    .catch(error => {
        console.error('Error fetching data:', error);
    });
}
loadSchedule();
