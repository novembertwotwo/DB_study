SELECT DATE_Format(SALES_DATE, '%Y-%m-%d') as SALES_DATE, -- '2022-05-24'형식으로 포맷
           PRODUCT_ID, -- 제품 ID
           USER_ID,  -- 회원 ID
           SALES_AMOUNT -- 판매량
        from ONLINE_SALE -- 온라인 고객
        where Month(SALES_DATE) = 3
union -- 쿼리의 결과를 합치고, 중복된 ROW는 제거한다. (오프라인/온라인의 쿼리 결과를 합친다는 의미)
    SELECT DATE_Format(SALES_DATE, '%Y-%m-%d') as SALES_DATE, -- '2022-05-24'형식으로 포맷
           PRODUCT_ID, 
           Null as USER_ID, -- 오프라인 고객은 USER_ID가 없으므로 NULL값으로 채우고 
           SALES_AMOUNT -- 판매량
        from OFFLINE_SALE -- 오프라인
        where Month(SALES_DATE) = 3
order by SALES_DATE, PRODUCT_ID, USER_ID


-- https://velog.io/@gayeong39/%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%A8%B8%EC%8A%A4-%EC%98%A4%ED%94%84%EB%9D%BC%EC%9D%B8%EC%98%A8%EB%9D%BC%EC%9D%B8-%ED%8C%90%EB%A7%A4-%EB%8D%B0%EC%9D%B4%ED%84%B0-%ED%86%B5%ED%95%A9%ED%95%98%EA%B8%B0

SQL의 **`UNION` 연산자**는 두 개 이상의 `SELECT` 쿼리 결과를 하나의 결과 집합으로 결합할 때 사용됩니다. 기본적으로 **중복된 행은 제거**되며, 중복을 포함하려면 `UNION ALL`을 사용해야 합니다.

---

## **`UNION`의 주요 특징**

1. **여러 쿼리 결과 결합**:
   - 두 개 이상의 `SELECT` 쿼리 결과를 하나로 결합합니다.
2. **중복 제거**:
   - 기본적으로 `UNION`은 중복된 행을 제거합니다.
3. **컬럼과 데이터 타입 일치 필요**:
   - 모든 `SELECT` 쿼리는 동일한 개수의 컬럼을 반환해야 하며, 각 컬럼의 데이터 타입이 호환되어야 합니다.
   - 컬럼 순서도 동일해야 합니다.
4. **정렬 가능**:
   - 최종 결과에 대해 `ORDER BY`를 사용해 정렬할 수 있습니다.

---

## **문법**

### **기본 UNION 문법**
```sql
SELECT column1, column2, ...
FROM table1
UNION
SELECT column1, column2, ...
FROM table2
[ORDER BY column];
```

### **UNION ALL 문법**
중복된 행을 포함하려면 `UNION ALL`을 사용합니다:
```sql
SELECT column1, column2, ...
FROM table1
UNION ALL
SELECT column1, column2, ...
FROM table2
[ORDER BY column];
```

---

## **예제**

### **1. 기본 UNION 예제**
두 개의 테이블 `Customers`와 `Suppliers`가 있고, 둘 다 `City` 컬럼을 가진다고 가정합니다.

#### 쿼리:
```sql
SELECT City FROM Customers
UNION
SELECT City FROM Suppliers
ORDER BY City;
```

#### 결과:
두 테이블에서 중복되지 않은 모든 도시(`City`)를 가져오고 알파벳 순으로 정렬합니다.

---

### **2. UNION ALL 예제**
중복된 도시도 포함하려면 `UNION ALL`을 사용합니다.

#### 쿼리:
```sql
SELECT City FROM Customers
UNION ALL
SELECT City FROM Suppliers
ORDER BY City;
```

#### 결과:
두 테이블에서 모든 도시를 가져오며 중복된 값도 포함됩니다.

---

### **3. WHERE 조건과 함께 사용**
각 쿼리에 조건을 추가하여 필요한 데이터만 결합할 수 있습니다.

#### 쿼리:
```sql
SELECT City, Country FROM Customers WHERE Country = 'Germany'
UNION
SELECT City, Country FROM Suppliers WHERE Country = 'Germany'
ORDER BY City;
```

#### 결과:
두 테이블에서 독일(`Germany`)에 해당하는 모든 도시와 국가 정보를 가져옵니다. 중복은 제거됩니다.

---

### **4. 추가 컬럼으로 데이터 출처 구분**
데이터가 어느 테이블에서 왔는지 구분하고 싶다면 새로운 컬럼을 추가할 수 있습니다.

#### 쿼리:
```sql
SELECT 'Customer' AS Type, ContactName, City FROM Customers
UNION
SELECT 'Supplier', ContactName, City FROM Suppliers;
```

#### 결과:
결과에 `Type` 컬럼이 추가되며, 값으로 `Customer` 또는 `Supplier`가 표시됩니다.

---

## **`UNION`과 `UNION ALL`의 차이점**

| 특징               | UNION                          | UNION ALL                     |
|--------------------|--------------------------------|--------------------------------|
| **중복 처리**       | 중복 제거                     | 중복 포함                     |
| **성능**           | 느림 (중복 제거 작업 필요)    | 빠름 (중복 제거 없음)         |
| **사용 사례**       | 고유한 데이터가 필요할 때     | 모든 데이터를 가져올 때       |

---

## **주의사항**

1. **컬럼 이름**:
   - 최종 결과의 컬럼 이름은 첫 번째 `SELECT` 쿼리에서 가져옵니다.
   - 예를 들어 첫 번째 쿼리가 `City`, 두 번째 쿼리가 동일한 위치에 다른 이름(`Location`)을 가진 경우에도 최종 결과는 `City`로 표시됩니다.

2. **ORDER BY 위치**:
   - `ORDER BY`는 전체 결과 집합에 대해 한 번만 사용할 수 있으며, 마지막에 작성해야 합니다.

3. **NULL 처리**:
   - NULL 값은 중복 제거 시 별도로 처리되며 서로 다른 값으로 간주되지 않습니다.

4. **데이터베이스 엔진 차이**:
   - MySQL과 같은 일부 데이터베이스에서는 기본적으로 `ONLY_FULL_GROUP_BY` 설정이 활성화되어 있어 특정 상황에서 오류가 발생할 수 있습니다.

---

## **결론**

- `UNION`은 여러 쿼리의 결과를 결합하고 중복을 제거할 때 유용합니다.
- 중복 데이터를 포함하려면 `UNION ALL`을 사용하세요.
- 다수의 테이블에서 데이터를 통합하거나 요약된 데이터를 생성하는 데 효과적입니다.
- 성능 최적화를 위해 필요한 데이터만 선택하도록 설계하는 것이 중요합니다.