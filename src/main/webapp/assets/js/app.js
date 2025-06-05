searchForm = document.querySelector(".search-form");

document.querySelector("#search-btn").onclick = () => {
  searchForm.classList.toggle("active");
};

let loginForm = document.querySelector(".login-form-container");

document.querySelector("#login-btn").onclick = () => {
  loginForm.classList.toggle("active");
};

document.querySelector("#close-login-btn").onclick = () => {
  loginForm.classList.remove("active");
};

window.onscroll = () => {
  searchForm.classList.remove("active");
  if (window.scrollY > 80) {
    document.querySelector(".header .header-2").classList.add("active");
  } else {
    document.querySelector(".header .header-2").classList.remove("active");
  }
};

window.onload = () => {
  if (window.scrollY > 80) {
    document.querySelector(".header .header-2").classList.add("active");
  } else {
    document.querySelector(".header .header-2").classList.remove("active");
  }

  fadeOut();
};

// Hiện popup khi trang vừa load
document.addEventListener("DOMContentLoaded", function () {
  const popup = document.getElementById("popup-overlay");
  const closeBtn = document.getElementById("close-popup");

  // Hiển thị popup với transition
  setTimeout(() => {
    popup.classList.add("show");
  }, 2500);

  // Đóng popup có hiệu ứng transition
  closeBtn.addEventListener("click", function () {
    popup.classList.remove("show");
  });
});
