USE olist_db;
SELECT * FROM olist_customers_dataset;

-- 1. 총 주문 수 조회
SELECT COUNT(*) AS total_orders
FROM olist_customers_dataset;

-- 2. 고객 수 조회
SELECT COUNT(*) AS total_customers
FROM olist_customers_dataset;

-- 3. 고객의 고유 사용자 수 조회
SELECT COUNT(DISTINCT customer_unique_id) AS unique_customers
FROM olist_customers_dataset;

-- 4. 주(state)별 고객 수 상위 10개
SELECT customer_state, COUNT(*) AS num_customers
FROM olist_customers_dataset
GROUP BY customer_state
ORDER BY num_customers DESC
LIMIT 10;

-- 5. 도시별 고객 수 집계
SELECT customer_city, COUNT(*) AS num_customers
FROM olist_customers_dataset
GROUP BY customer_city
ORDER BY num_customers DESC;

-- 6. 우편번호별 고객 분포
SELECT customer_zip_code_prefix, COUNT(*) AS cnt
FROM olist_customers_dataset
GROUP BY customer_zip_code_prefix
ORDER BY cnt DESC;

-- 7. 특정 주(state)의 고객만 조회
SELECT *
FROM olist_customers_dataset
WHERE customer_state = 'SP'
LIMIT 20;

-- 8. 주(state)별 고객 수 순위 매기기
SELECT
	customer_state,
    COUNT(*) AS num_customers,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS state_rank
FROM olist_customers_dataset
GROUP BY customer_state;

-- JOIN 함수를 위한 가상의 테이블 생성
-- 예시용 지역 테이블
CREATE TABLE zipcode_info (
	customer_zip_code_prefix VARCHAR(20),
    region_name VARCHAR(50)
);

-- 고객 테이블과 지역 테이블 JOIN
SELECT
	c.customer_id,
    c.customer_city,
    c.customer_zip_code_prefix,
    z.region_name
FROM olist_customers_dataset c
LEFT JOIN zipcode_info z
	ON c.customer_zip_code_prefix = z.customer_zip_code_prefix
LIMIT 20;