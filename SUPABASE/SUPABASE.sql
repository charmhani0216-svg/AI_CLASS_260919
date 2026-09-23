-- Menu 섹션용 테이블 생성 SQL (메뉴 5개 버전)
-- Supabase 대시보드 > SQL Editor에 아래 내용을 그대로 붙여넣고 실행하세요.
-- 이미 실행한 적이 있어도 에러 없이 다시 실행할 수 있도록 작성되었습니다.

-- 1. 기존 테이블이 있다면 삭제 후 새로 생성
drop table if exists menu cascade;

create table menu (
  id bigint generated always as identity primary key,
  name text not null,
  description text,
  price integer not null,
  image_url text,
  sort_order integer default 0
);

-- 2. 메뉴 5개 등록 (가상 메뉴)
insert into menu (name, description, price, image_url, sort_order) values
  ('Cream Latte', '부드러운 크림 폼과 진한 에스프레소가 어우러진 시그니처 라떼', 6500, 'img/Cream Latte.jpg', 1),
  ('Hazelnut Mocha', '고소한 헤이즐넛 시럽과 초콜릿이 조화를 이루는 달콤한 모카', 6800, 'img/Hazelnut Mocha.jpg', 2),
  ('Classic Tiramisu', '진한 마스카포네 크림과 커피 향을 담은 수제 티라미수', 7000, 'img/Classic Tiramisu.png', 3),
  ('Mellow Ade', '레몬과 허브를 사용한 상큼한 시그니처 에이드', 6000, 'img/AVATAR Ade.jpg', 4),
  ('Brown Sugar Milk Tea', '진한 흑당 시럽과 부드러운 우유가 어우러진 달콤한 밀크티', 6200, 'img/Brown Sugar Milk Tea.jpg', 5);

-- 3. 누구나 메뉴를 읽을 수 있도록 공개 권한 설정
alter table menu enable row level security;

drop policy if exists "메뉴는 누구나 조회 가능" on menu;

create policy "메뉴는 누구나 조회 가능"
  on menu for select
  using (true);
