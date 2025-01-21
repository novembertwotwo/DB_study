select PT_NAME, PT_NO	,	GEND_CD,	AGE,	
case when TLNO is null then 'NONE' else TLNO end as TLNO
from PATIENT
where AGE <= 12 && GEND_CD = 'W'
order by AGE desc, PT_NAME

SQL의 **CASE WHEN** 구문은 조건에 따라 다른 값을 반환하는 **조건문**으로, 프로그래밍 언어의 `if-else`와 유사한 역할을 합니다. 이 구문은 데이터 조회, 변환, 집계 등 다양한 작업에서 활용됩니다.

## **CASE WHEN 기본 구조**
CASE 문은 두 가지 유형으로 나뉩니다:
1. **단순 CASE 표현식**: 특정 값과 비교
2. **검색 CASE 표현식**: 조건을 직접 평가

### **1. 단순 CASE 표현식**
단순 CASE는 특정 값과 비교하여 조건을 평가합니다.

```sql
CASE column_name
    WHEN value1 THEN result1
    WHEN value2 THEN result2
    ELSE default_result
END
```

#### 예제:
```sql
SELECT employee_id,
       job_title,
       CASE job_title
           WHEN 'MANAGER' THEN 'Manager'
           WHEN 'SALESMAN' THEN 'Salesman'
           ELSE 'Other'
       END AS job_category
FROM employees;
```
- `job_title`이 'MANAGER'이면 'Manager', 'SALESMAN'이면 'Salesman', 그 외에는 'Other'를 반환합니다.

---

### **2. 검색 CASE 표현식**
검색 CASE는 조건을 직접 지정하여 평가합니다.

```sql
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ELSE default_result
END
```

#### 예제:
```sql
SELECT order_id,
       amount,
       CASE 
           WHEN amount >= 10000 THEN 'High Value'
           WHEN amount >= 5000 THEN 'Medium Value'
           ELSE 'Low Value'
       END AS order_category
FROM orders;
```
- `amount`가 10,000 이상이면 'High Value', 5,000 이상이면 'Medium Value', 그 외에는 'Low Value'를 반환합니다.

---

## **CASE WHEN 활용 사례**
### **1. SELECT 문에서 새로운 열 생성**
CASE 문은 SELECT 절에서 조건에 따라 새로운 열을 생성할 수 있습니다.

```sql
SELECT customer_id,
       age,
       CASE 
           WHEN age < 30 THEN 'Young'
           WHEN age BETWEEN 30 AND 60 THEN 'Middle-aged'
           ELSE 'Senior'
       END AS age_group
FROM customers;
```

### **2. ORDER BY에서 조건부 정렬**
CASE 문은 ORDER BY 절에서도 사용 가능합니다.

```sql
SELECT customer_name, city, country
FROM customers
ORDER BY 
    CASE 
        WHEN city IS NULL THEN country 
        ELSE city 
    END;
```
- `city`가 NULL인 경우에는 `country`로 정렬하고, 그렇지 않으면 `city`로 정렬합니다.

### **3. 집계 함수와 결합**
CASE 문은 집계 함수와 함께 사용하여 조건부 집계를 수행할 수 있습니다.

```sql
SELECT SUM(CASE WHEN region = 'North' THEN sales ELSE 0 END) AS NorthSales,
       SUM(CASE WHEN region = 'South' THEN sales ELSE 0 END) AS SouthSales
FROM sales_data;
```
- 지역별 판매량을 계산합니다.

---

## **주의사항**
- **END 필수**: 모든 CASE 문은 반드시 `END`로 종료해야 합니다[3][6].
- **순차 평가**: 조건은 순서대로 평가되며, 첫 번째로 참인 조건의 결과를 반환합니다[5][13].
- **ELSE 절 선택적 사용**: ELSE 절이 없으면 조건에 맞지 않는 경우 NULL을 반환합니다[6][23].

---

SQL의 CASE WHEN 구문은 데이터 변환과 조건부 로직 구현에 매우 유용하며, SELECT, UPDATE, ORDER BY 등 다양한 SQL 명령어와 함께 사용할 수 있습니다.
