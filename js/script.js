// 푸터에 현재 연도 자동으로 표시하기
const yearEl = document.getElementById("year");
yearEl.textContent = new Date().getFullYear();

// Supabase 연결 정보
const SUPABASE_URL = "https://zkrmrzhajvrodmjgaswz.supabase.co";
const SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inprcm1yemhhanZyb2Rtamdhc3d6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTAxNTU5MDMsImV4cCI6MjEwNTczMTkwM30.eZbnBsVVP0UIUhvMbuFH11hK6rcZXlkc5QO4R9RnaJ0";

const supabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

// Menu 테이블에서 메뉴 목록을 불러와 카드로 그려주기
async function loadMenu() {
  const menuListEl = document.getElementById("menu-list");

  const { data: menuItems, error } = await supabase
    .from("menu")
    .select("*")
    .order("sort_order", { ascending: true });

  if (error) {
    console.error("메뉴를 불러오는 중 오류가 발생했습니다.", error);
    menuListEl.innerHTML = "<p>메뉴를 불러오지 못했습니다.</p>";
    return;
  }

  menuListEl.innerHTML = menuItems.map(item => `
    <div class="menu-card">
      <img class="menu-img" src="${item.image_url}" alt="${item.name}">
      <h3>${item.name}</h3>
      <p>${item.description}</p>
      <p class="price">${item.price.toLocaleString()}원</p>
    </div>
  `).join("");
}

loadMenu();
