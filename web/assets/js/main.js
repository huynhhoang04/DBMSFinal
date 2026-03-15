
let currentMovieId = null;
let activeDate = "";
let activeCity = "Hà Nội";

function openBookingModal(movieId) {
    currentMovieId = movieId;
    document.getElementById("bookingModal").style.display = "flex";
    document.body.style.overflow = "hidden";

    renderDates();
    fetchShowtimes();
}

function renderDates() {
    let container = document.getElementById("dateListContainer");
    container.innerHTML = "";

    for (let i = 0; i < 3; i++) {
        let d = new Date();
        d.setDate(d.getDate() + i);

        let month = d.getMonth() + 1;
        let day = d.getDate();
        let dateString = d.getFullYear() + "-" + String(month).padStart(2, '0') + "-" + String(day).padStart(2, '0');

        let dow = i === 0 ? "Hôm nay" : "Thứ " + (d.getDay() === 0 ? "Chủ nhật" : d.getDay() + 1);

        if (i === 0) activeDate = dateString;

        container.innerHTML += `
            <div class="date-item ${i === 0 ? 'active' : ''}" onclick="selectDate(this, '${dateString}')">
                <span class="month">Tháng ${month}</span>
                <span class="day">${day}</span>
                <span class="dow">${dow}</span>
            </div>
        `;
    }
}

function selectDate(element, selectedDate) {
    document.querySelectorAll('.date-item').forEach(d => d.classList.remove('active'));
    element.classList.add('active');
    activeDate = selectedDate;
    fetchShowtimes();
}

function selectCity(element, selectedCity) {
    document.querySelectorAll('.city-item').forEach(c => c.classList.remove('active'));
    element.classList.add('active');
    activeCity = selectedCity;
    fetchShowtimes();
}

function fetchShowtimes() {
    let container = document.getElementById("theatreListContainer");
    container.innerHTML = "<div style='text-align:center; color:#888;'>Đang tải lịch chiếu...</div>";

    fetch(`/api/movie/showtimes?id=${currentMovieId}&date=${activeDate}&city=${encodeURIComponent(activeCity)}`)
        .then(response => {
            if (!response.ok) throw new Error("Lỗi mạng hoặc API");
            return response.json();
        })
        .then(data => {
            if (data.length === 0) {
                container.innerHTML = "<div style='text-align:center; color:#e50914;'>Không có suất chiếu nào trong ngày này.</div>";
                return;
            }

            let theatres = {};
            data.forEach(item => {
                if (!theatres[item.theatreName]) theatres[item.theatreName] = [];
                theatres[item.theatreName].push(item);
            });

            container.innerHTML = "";
            for (let theatre in theatres) {
                let showtimesHTML = theatres[theatre].map(st => `
                    <a href="booking?showtime_id=${st.showtimeId}" class="showtime-btn">
                        <span class="time">${formatTime(st.startAt)}</span>
                        <span class="type">Phòng ${st.roomName}</span>
                    </a>
                `).join("");

                container.innerHTML += `
                    <div class="theatre-group">
                        <h4 class="theatre-name">${theatre}</h4>
                        <div class="showtimes">${showtimesHTML}</div>
                    </div>
                `;
            }
        })
        .catch(error => {
            console.error("Lỗi:", error);
            container.innerHTML = "<div style='text-align:center; color:red;'>Lỗi tải dữ liệu.</div>";
        });
}

function formatTime(timestampStr) {
    if (!timestampStr) return "";
    let t = timestampStr.split(" ")[1];
    if(t) return t.substring(0, 5);
    return timestampStr;
}

function closeBookingModal() {
    document.getElementById("bookingModal").style.display = "none";
    document.body.style.overflow = "auto";
}

window.onclick = function(event) {
    let modal = document.getElementById("bookingModal");
    if (event.target == modal) {
        closeBookingModal();
    }
}

document.addEventListener('DOMContentLoaded', function() {
    const seatGrid = document.getElementById('seatGrid');

    // Nếu tìm thấy cái Sơ đồ ghế -> Tức là đang đứng ở trang Booking -> Chạy code!
    if (seatGrid) {
        let selectedSeatsArr = [];
        const rows = ROOM_CAPACITY / 10; // Đọc biến Global từ JSP truyền vào

        // 1. Vòng lặp đẻ ra ghế
        for (let r = 0; r < rows; r++) {
            const rowChar = String.fromCharCode(65 + r);
            for (let c = 1; c <= 10; c++) {
                const seatName = rowChar + c;

                const seatDiv = document.createElement('div');
                seatDiv.classList.add('seat');
                seatDiv.innerText = seatName;
                seatDiv.dataset.seatName = seatName;

                // Đọc biến BOOKED_SEATS từ JSP để bôi đỏ
                if (BOOKED_SEATS.includes(seatName)) {
                    seatDiv.classList.add('sold');
                    seatDiv.innerText = 'X';
                } else {
                    seatDiv.addEventListener('click', () => toggleSeat(seatDiv));
                }
                seatGrid.appendChild(seatDiv);
            }
        }

        // 2. Hàm click chọn ghế
        function toggleSeat(seatElement) {
            const seatName = seatElement.dataset.seatName;
            seatElement.classList.toggle('selected');

            if (seatElement.classList.contains('selected')) {
                selectedSeatsArr.push(seatName);
            } else {
                selectedSeatsArr = selectedSeatsArr.filter(s => s !== seatName);
            }
            updateCheckoutInfo();
        }

        // 3. Hàm tính tiền và cập nhật Form
        function updateCheckoutInfo() {
            document.getElementById('selectedSeatsText').innerText = selectedSeatsArr.length > 0 ? selectedSeatsArr.join(", ") : "Chưa chọn";

            // Đọc biến TICKET_PRICE từ JSP
            const totalPrice = selectedSeatsArr.length * TICKET_PRICE;
            document.getElementById('totalPriceText').innerText = totalPrice.toLocaleString('vi-VN') + " VNĐ";
            document.getElementById('totalPaymentInput').value = totalPrice;

            const hiddenContainer = document.getElementById('hiddenSeatsContainer');
            hiddenContainer.innerHTML = '';

            selectedSeatsArr.forEach(seat => {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'seats';
                input.value = seat;
                hiddenContainer.appendChild(input);
            });

            document.getElementById('btnSubmit').disabled = selectedSeatsArr.length === 0;
        }
    }
});

document.addEventListener('DOMContentLoaded', function() {
    const payForm = document.getElementById('payForm');
    const btnConfirmPay = document.getElementById('btnConfirmPay');

    // Nếu tồn tại form thanh toán (đang ở trang pay)
    if (payForm && btnConfirmPay) {
        payForm.addEventListener('submit', function(e) {
            // Thay đổi trạng thái nút ngay khi bấm
            btnConfirmPay.innerText = 'Đang xử lý giao dịch...';
            btnConfirmPay.style.pointerEvents = 'none'; // Chặn click tiếp
            btnConfirmPay.disabled = true; // Vô hiệu hóa nút

            // Trình duyệt sẽ tự động tiếp tục submit form POST về Servlet
        });
    }
});