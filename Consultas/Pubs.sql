--Consultas con INNER JOIN
--1. Encuentra los nombres de todos los autores junto con la cantidad total de libros que han escrito.
SELECT authors.au_id, authors.au_lname, authors.au_fname, COUNT(titles.title_id) AS total_books
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY total_books DESC;

--2. Encuentra los nombres de los editores junto con la cantidad total de libros que han publicado. Muestra todos los editores, incluso aquellos que no han publicado libros, y ordena por la cantidad de libros de manera descendente.
SELECT publishers.pub_id, publishers.pub_name, COALESCE(COUNT(titles.title_id), 0) AS total_libros_publicados
FROM publishers
LEFT JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_id, publishers.pub_name
ORDER BY total_libros_publicados DESC;

--3. Muestra los títulos de los libros y la cantidad total de copias vendidas de cada título. Incluye solo los libros que tienen ventas registradas y ordena por la cantidad total de copias vendidas de manera descendente.
SELECT titles.title, COALESCE(SUM(sales.qty), 0) AS total_copias_vendidas
FROM titles
LEFT JOIN sales ON titles.title_id = sales.title_id
GROUP BY titles.title
HAVING SUM(sales.qty) > 0
ORDER BY total_copias_vendidas DESC;

--4. Encuentra la cantidad total de libros vendidos por cada tienda y muestra solo las tiendas que han vendido más de 500 libros en total.
SELECT stores.stor_id, stores.stor_name, SUM(sales.qty) AS total_books_sold
FROM stores
INNER JOIN sales ON stores.stor_id = sales.stor_id
GROUP BY stores.stor_id, stores.stor_name
HAVING SUM(sales.qty) > 500;

--5. Encuentra el nombre de cada autor junto con la cantidad total de libros que ha escrito. Muestra todos los autores, incluso aquellos que no han escrito libros, y ordena por la cantidad de libros de manera descendente.
SELECT authors.au_id, authors.au_lname, authors.au_fname, COALESCE(COUNT(titleauthor.title_id), 0) AS total_libros
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY total_libros DESC;

--6. Encuentra la cantidad total de ventas y el nombre del título más vendido.
SELECT titles.title, SUM(sales.qty) AS total_sales
FROM titles
INNER JOIN sales ON titles.title_id = sales.title_id
GROUP BY titles.title
HAVING SUM(sales.qty) = (SELECT MAX(total_sales) FROM (SELECT title_id, SUM(qty) AS total_sales FROM sales GROUP BY title_id) AS subquery);

--7. Encuentra el nombre de los autores que no tienen libros publicados.
SELECT authors.au_id, authors.au_lname, authors.au_fname
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
WHERE titles.title_id IS NULL;

--8. Encuentra los nombres de los autores junto con la cantidad total de libros que han vendido.
SELECT authors.au_fname, authors.au_lname, SUM(sales.qty) AS total_libros_vendidos
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
INNER JOIN sales ON titles.title_id = sales.title_id
GROUP BY authors.au_fname, authors.au_lname;

--9. Encuentra los nombres de los empleados junto con sus títulos de trabajo. Muestra solo a los empleados que tienen un título de trabajo especificado.
SELECT employee.fname, employee.lname, jobs.job_desc
FROM employee
INNER JOIN jobs ON employee.job_id = jobs.job_id
WHERE jobs.job_desc = 'Editor'
ORDER BY employee.lname, employee.fname;

--10. Muestra los nombres de las tiendas y la cantidad total de ventas en 1993. Incluye solo las tiendas que tuvieron ventas en ese año y ordena por la cantidad total de ventas de manera descendente.
SELECT stores.stor_name, SUM(sales.qty) AS total_ventas_1993
FROM stores
INNER JOIN sales ON stores.stor_id = sales.stor_id
WHERE YEAR(sales.ord_date) = 1993
GROUP BY stores.stor_name
ORDER BY total_ventas_1993 DESC;

--11. Encuentra los nombres de las tiendas junto con el total de ventas de cada tienda.
SELECT s.stor_id, s.stor_name, SUM(sales.qty) AS total_ventas
FROM stores s
INNER JOIN sales ON s.stor_id = sales.stor_id
GROUP BY s.stor_id, s.stor_name;

--12. Encuentra los títulos de libros junto con el nombre de los editores. Muestra solo los libros que tienen un editor asociado.
SELECT titles.title, publishers.pub_name
FROM titles
INNER JOIN publishers ON titles.pub_id = publishers.pub_id
ORDER BY titles.title;

--13. Encuentra los títulos de libros junto con el nombre de la editorial que los publicó.
SELECT titles.title, publishers.pub_name
FROM titles
INNER JOIN publishers ON titles.pub_id = publishers.pub_id;

--14. Encuentra los títulos de libros y el número de ventas de cada libro.
SELECT titles.title, SUM(sales.qty) AS numero_ventas
FROM titles
INNER JOIN sales ON titles.title_id = sales.title_id
GROUP BY titles.title;

--15. Muestra los nombres de las tiendas y la cantidad total de ventas en 1992. Incluye solo las tiendas que tuvieron ventas en ese año y ordena por la cantidad total de ventas de manera descendente.
SELECT stores.stor_name, SUM(sales.qty) AS total_ventas_1992
FROM stores
INNER JOIN sales ON stores.stor_id = sales.stor_id
WHERE YEAR(sales.ord_date) = 1992
GROUP BY stores.stor_name
ORDER BY total_ventas_1992 DESC;

--16. Encuentra los nombres de los autores junto con la fecha de su última publicación.
SELECT a.au_id, a.au_fname, a.au_lname, MAX(t.pubdate) AS ultima_publicacion
FROM authors a
INNER JOIN titleauthor ta ON a.au_id = ta.au_id
INNER JOIN titles t ON ta.title_id = t.title_id
GROUP BY a.au_id, a.au_fname, a.au_lname;

--17. Encuentra los títulos de libros junto con el nombre de la editorial y el nombre del autor.
SELECT t.title, p.pub_name, CONCAT(a.au_fname, ' ', a.au_lname) AS autor
FROM titles t
INNER JOIN publishers p ON t.pub_id = p.pub_id
INNER JOIN titleauthor ta ON t.title_id = ta.title_id
INNER JOIN authors a ON ta.au_id = a.au_id;

--18. Encuentra los nombres de los empleados que tienen el mismo cargo.
SELECT e1.emp_id, e1.fname, e1.lname, e1.job_id
FROM employee e1
INNER JOIN employee e2 ON e1.job_id = e2.job_id AND e1.emp_id <> e2.emp_id;

--19. Encuentra los nombres de los autores que han escrito al menos un libro vendido más de 100 veces.
SELECT a.au_id, a.au_fname, a.au_lname
FROM authors a
INNER JOIN titleauthor ta ON a.au_id = ta.au_id
INNER JOIN titles t ON ta.title_id = t.title_id
INNER JOIN sales s ON t.title_id = s.title_id
WHERE s.qty > 100;

--20. Encuentra los títulos de libros junto con los nombres de los autores. Muestra solo los libros publicados antes de 1995 y ordena por año de publicación de manera ascendente.
SELECT titles.title, authors.au_fname, authors.au_lname
FROM titles
INNER JOIN titleauthor ON titles.title_id = titleauthor.title_id
INNER JOIN authors ON titleauthor.au_id = authors.au_id
WHERE YEAR(titles.pubdate) < 1995
ORDER BY titles.pubdate ASC;

--21. Encuentra los nombres de los autores junto con el título de su libro más vendido.
SELECT authors.au_id, authors.au_fname, authors.au_lname, titles.title
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
WHERE titles.title_id = (
    SELECT TOP 1 title_id
    FROM sales
    GROUP BY title_id
    ORDER BY SUM(qty) DESC
);

--22. Encuentra los nombres de las tiendas junto con el total de ventas y muestra solo las tiendas que han vendido al menos un libro de negocios.
SELECT s.stor_id, s.stor_name, SUM(sales.qty) AS total_ventas
FROM stores s
INNER JOIN sales ON s.stor_id = sales.stor_id
INNER JOIN titles t ON sales.title_id = t.title_id
WHERE t.type = 'business'
GROUP BY s.stor_id, s.stor_name
HAVING SUM(sales.qty) > 0;

--23. Muestra el nombre de los editores junto con la cantidad de títulos de libros que han publicado. Incluye solo los editores que han publicado al menos un libro y ordena por la cantidad de títulos de manera descendente.
SELECT publishers.pub_name, COUNT(titles.title_id) AS total_libros_publicados
FROM publishers
INNER JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_name
HAVING COUNT(titles.title_id) > 0
ORDER BY total_libros_publicados DESC;

-- 24. Encuentra autores junto con la cantidad total de libros que han escrito. Muestra solo los autores que han escrito al menos un libro y ordena por la cantidad de libros de manera descendente.
SELECT authors.au_id, authors.au_lname, authors.au_fname, COUNT(titleauthor.title_id) AS total_libros_escritos
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
HAVING COUNT(titleauthor.title_id) > 0
ORDER BY total_libros_escritos DESC;

--25. Encuentra los títulos de libros y muestra la fecha de la primera venta de cada libro.
SELECT titles.title, MIN(sales.ord_date) AS fecha_primera_venta
FROM titles
INNER JOIN sales ON titles.title_id = sales.title_id
GROUP BY titles.title;

--Consultas con LEFT JOIN
--1. Encuentra los nombres de los autores junto con la cantidad total de libros que han escrito, mostrando solo los autores que han escrito al menos 3 libros.
SELECT authors.au_id, authors.au_fname, authors.au_lname, COUNT(titles.title_id) AS total_libros
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_fname, authors.au_lname
HAVING COUNT(titles.title_id) >= 3;

--2. Encuentra los títulos de libros junto con el nombre de la editorial y muestra solo los libros que se publicaron antes de 1990, ordenados por fecha de publicación de manera ascendente.
SELECT titles.title, publishers.pub_name, titles.pubdate
FROM titles
LEFT JOIN publishers ON titles.pub_id = publishers.pub_id
WHERE YEAR(titles.pubdate) < 1990
ORDER BY titles.pubdate ASC;

--3. Encuentra autores junto con la cantidad total de libros que han escrito. Muestra todos los autores, incluso aquellos que no han escrito libros.
SELECT authors.au_id, authors.au_fname, authors.au_lname, COALESCE(COUNT(titleauthor.title_id), 0) AS total_libros_escritos
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
GROUP BY authors.au_id, authors.au_fname, authors.au_lname
ORDER BY authors.au_lname, authors.au_fname;

--4. Encuentra los títulos de libros y muestra el número de ventas de cada libro, ordenados por número de ventas de manera descendente.
SELECT titles.title, COUNT(sales.title_id) AS numero_ventas
FROM titles
LEFT JOIN sales ON titles.title_id = sales.title_id
GROUP BY titles.title
ORDER BY numero_ventas DESC;

--5. Encuentra los nombres de las tiendas y muestra la cantidad total de ventas realizadas en cada tienda en 1994, excluyendo las tiendas que no han tenido ventas en ese año.
SELECT stores.stor_name, SUM(sales.qty) AS total_ventas_1994
FROM stores
LEFT JOIN sales ON stores.stor_id = sales.stor_id
WHERE YEAR(sales.ord_date) = 1994
GROUP BY stores.stor_name
HAVING SUM(sales.qty) > 0;

--6. Encuentra los títulos de libros junto con el nombre de los autores y muestra solo los libros escritos por más de un autor.
SELECT titles.title, authors.au_fname, authors.au_lname
FROM titles
LEFT JOIN titleauthor ON titles.title_id = titleauthor.title_id
LEFT JOIN authors ON titleauthor.au_id = authors.au_id
WHERE titles.title_id IN (
    SELECT title_id
    FROM titleauthor
    GROUP BY title_id
    HAVING COUNT(title_id) > 1
);

--7. Encuentra los nombres de los autores y muestra la cantidad total de libros que han escrito, excluyendo a aquellos que no han escrito ningún libro.
SELECT authors.au_id, authors.au_fname, authors.au_lname, COUNT(titles.title_id) AS total_libros
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_fname, authors.au_lname
HAVING COUNT(titles.title_id) > 0;

--8. Encuentra los títulos de libros y muestra la fecha de la última venta de cada libro, excluyendo los libros que no han sido vendidos.
SELECT titles.title, MAX(sales.ord_date) AS ultima_venta
FROM titles
LEFT JOIN sales ON titles.title_id = sales.title_id
GROUP BY titles.title
HAVING MAX(sales.ord_date) IS NOT NULL;

-- 9. Encuentra los nombres de las tiendas y muestra el nombre del libro más vendido en cada tienda.
SELECT s.stor_name, t.title
FROM stores s
LEFT JOIN (
    SELECT sa.stor_id, sa.title_id, MAX(sa.qty) AS max_qty
    FROM sales sa
    GROUP BY sa.stor_id, sa.title_id
) AS max_sales ON s.stor_id = max_sales.stor_id
LEFT JOIN titles t ON max_sales.title_id = t.title_id

--10. Encuentra los nombres de los autores junto con el título de su libro más antiguo, excluyendo a aquellos autores que no han publicado ningún libro.
SELECT authors.au_id, authors.au_fname, authors.au_lname, titles.title, MIN(titles.pubdate) AS libro_mas_antiguo
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_fname, authors.au_lname, titles.title
HAVING MIN(titles.pubdate) IS NOT NULL;

--11. Encuentra los nombres de los autores junto con el título de su libro más reciente, excluyendo a aquellos autores que no han publicado ningún libro.
SELECT authors.au_id, authors.au_fname, authors.au_lname, titles.title, MAX(titles.pubdate) AS libro_mas_reciente
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_fname, authors.au_lname
HAVING MAX(titles.pubdate) IS NOT NULL;

--12. Encuentra los títulos de libros y muestra el número total de copias vendidas de cada libro en el año 1994.
SELECT titles.title, SUM(sales.qty) AS total_copias_vendidas_1994
FROM titles
LEFT JOIN sales ON titles.title_id = sales.title_id
WHERE YEAR(sales.ord_date) = 1994
GROUP BY titles.title;

--13. Encuentra empleados que no tienen trabajos asignados y muestra sus nombres. Incluye todos los empleados, incluso aquellos sin trabajo asignado.
SELECT employee.fname, employee.lname
FROM employee
LEFT JOIN jobs ON employee.job_id = jobs.job_id
WHERE jobs.job_desc IS NULL
ORDER BY employee.lname, employee.fname;

--14. Encuentra los nombres de las editoriales y muestra la cantidad total de libros que han publicado, ordenando el resultado por cantidad de libros de manera descendente.
SELECT publishers.pub_name, COUNT(titles.title_id) AS total_libros_publicados
FROM publishers
LEFT JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_name
ORDER BY total_libros_publicados DESC;

--15. Encuentra los títulos de libros y muestra la fecha de la última venta de cada libro, excluyendo los libros que no han sido vendidos.
SELECT titles.title, MAX(sales.ord_date) AS ultima_venta
FROM titles
LEFT JOIN sales ON titles.title_id = sales.title_id
GROUP BY titles.title
HAVING MAX(sales.ord_date) IS NOT NULL;

--16. Encuentra los nombres de los autores junto con el número total de libros que han escrito, mostrando solo los autores que han escrito más de 5 libros.
SELECT authors.au_id, authors.au_fname, authors.au_lname, COUNT(titleauthor.title_id) AS total_libros
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
GROUP BY authors.au_id, authors.au_fname, authors.au_lname
HAVING COUNT(titleauthor.title_id) > 5;

--17. entra los nombres de las tiendas y muestra la cantidad total de ventas realizadas en cada tienda en 1994, excluyendo las tiendas que no han tenido ventas en ese año.
SELECT stores.stor_name, SUM(sales.qty) AS total_ventas_1994
FROM stores
LEFT JOIN sales ON stores.stor_id = sales.stor_id
WHERE YEAR(sales.ord_date) = 1994
GROUP BY stores.stor_name
HAVING SUM(sales.qty) > 0;

--18. Encuentra los nombres de los autores junto con la cantidad total de libros que han escrito, excluyendo a aquellos autores que no han publicado ningún libro.
SELECT authors.au_id, authors.au_fname, authors.au_lname, COUNT(titles.title_id) AS total_libros
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_fname, authors.au_lname
HAVING COUNT(titles.title_id) > 0;

--19. Encuentra tiendas que tienen ventas en 1994 y muestra el nombre de la tienda junto con el total de ventas en ese año.
SELECT stores.stor_name, COALESCE(SUM(sales.qty), 0) AS total_ventas_1994
FROM stores
LEFT JOIN sales ON stores.stor_id = sales.stor_id
WHERE YEAR(sales.ord_date) = 1994
GROUP BY stores.stor_name
ORDER BY stores.stor_name;

--20. Encuentra los títulos de libros junto con la fecha de la última venta de cada libro, excluyendo los libros que no han sido vendidos.
SELECT t.title, MAX(s.ord_date) AS ultima_venta
FROM titles t
LEFT JOIN sales s ON t.title_id = s.title_id
GROUP BY t.title
HAVING MAX(s.ord_date) IS NOT NULL;

--21. Encuentra los nombres de las editoriales junto con la cantidad total de libros que han publicado, ordenando el resultado por cantidad de libros de manera descendente.
SELECT p.pub_name, COALESCE(COUNT(t.title_id), 0) AS total_libros_publicados
FROM publishers p
LEFT JOIN titles t ON p.pub_id = t.pub_id
GROUP BY p.pub_name
ORDER BY total_libros_publicados DESC;

--22. Encuentra los nombres de las tiendas junto con la cantidad total de ventas realizadas en cada tienda en 1994, excluyendo las tiendas que no han tenido ventas en ese año.
SELECT st.stor_name, COALESCE(SUM(s.qty), 0) AS total_ventas_1994
FROM stores st
LEFT JOIN sales s ON st.stor_id = s.stor_id
WHERE YEAR(s.ord_date) = 1994
GROUP BY st.stor_name
HAVING COALESCE(SUM(s.qty), 0) > 0;

--23. Encuentra los títulos de libros junto con el nombre de la editorial y muestra solo los libros que tienen la palabra "The" en su título, sin importar mayúsculas o minúsculas.
SELECT titles.title, publishers.pub_name
FROM titles
LEFT JOIN publishers ON titles.pub_id = publishers.pub_id
WHERE LOWER(titles.title) LIKE '%The%';

--24. Encuentra los nombres de los autores junto con el título de su libro más reciente, excluyendo a aquellos autores que no han publicado ningún libro.
SELECT authors.au_id, authors.au_fname, authors.au_lname, titles.title, MAX(titles.pubdate) AS libro_mas_reciente
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_fname, authors.au_lname
HAVING MAX(titles.pubdate) IS NOT NULL;

--25. Encuentra títulos de libros actuales que tengan una fecha de publicación posterior a títulos anteriores y muestra ambos títulos.
SELECT t1.title AS titulo_actual, t2.title AS titulo_anterior
FROM titles t1
LEFT JOIN titles t2 ON t1.title_id <> t2.title_id AND t1.pubdate > t2.pubdate;

--Consultas con RIGHT JOIN
--1. Encuentra los nombres de los autores junto con la cantidad total de libros que han escrito, mostrando solo los autores que han escrito al menos 3 libros. Ordena el resultado por la cantidad de libros de manera descendente.
SELECT authors.au_id, authors.au_fname, authors.au_lname, COUNT(titles.title_id) AS total_libros
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
RIGHT JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_fname, authors.au_lname
HAVING COUNT(titles.title_id) >= 3
ORDER BY total_libros DESC;

--2. Encuentra los títulos de libros junto con el nombre de la editorial y muestra solo los libros que se publicaron antes de 1990. Ordena el resultado por fecha de publicación de manera ascendente.
SELECT titles.title, publishers.pub_name, titles.pubdate
FROM titles
RIGHT JOIN publishers ON titles.pub_id = publishers.pub_id
WHERE YEAR(titles.pubdate) < 1990
ORDER BY titles.pubdate ASC;

--3. Muestra el nombre de las tiendas junto con el total de ventas en 1993. Incluye todas las tiendas, incluso aquellas que no tuvieron ventas en ese año.
SELECT stores.stor_name, COALESCE(SUM(sales.qty), 0) AS total_ventas_1993
FROM sales
RIGHT JOIN stores ON sales.stor_id = stores.stor_id
WHERE YEAR(sales.ord_date) = 1993
GROUP BY stores.stor_name
ORDER BY stores.stor_name;

--4. Encuentra los títulos de libros junto con el número de ventas de cada libro. Muestra solo los libros que han sido vendidos al menos una vez. Ordena el resultado por el número de ventas de manera descendente.
SELECT titles.title, COUNT(sales.title_id) AS numero_ventas
FROM titles
RIGHT JOIN sales ON titles.title_id = sales.title_id
GROUP BY titles.title
HAVING COUNT(sales.title_id) > 0
ORDER BY numero_ventas DESC;

--5. Encuentra los nombres de las tiendas junto con la cantidad total de ventas realizadas en 1994. Muestra solo las tiendas que han tenido ventas en ese año. Ordena el resultado por la cantidad de ventas de manera descendente.
SELECT stores.stor_name, SUM(sales.qty) AS total_ventas_1994
FROM stores
RIGHT JOIN sales ON stores.stor_id = sales.stor_id
WHERE YEAR(sales.ord_date) = 1994
GROUP BY stores.stor_name
HAVING SUM(sales.qty) > 0
ORDER BY total_ventas_1994 DESC;

--6. Encuentra los títulos de libros junto con el nombre de los autores y muestra solo los libros escritos por más de un autor. Ordena el resultado por el título del libro.
SELECT titles.title, authors.au_fname, authors.au_lname
FROM titles
RIGHT JOIN titleauthor ON titles.title_id = titleauthor.title_id
RIGHT JOIN authors ON titleauthor.au_id = authors.au_id
WHERE titles.title_id IN (
    SELECT title_id
    FROM titleauthor
    GROUP BY title_id
    HAVING COUNT(title_id) > 1
)
ORDER BY titles.title;

--7. Encuentra los nombres de las editoriales junto con la cantidad total de libros que han publicado. Ordena el resultado por la cantidad de libros de manera descendente.
SELECT publishers.pub_name, COUNT(titles.title_id) AS total_libros_publicados
FROM publishers
RIGHT JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_name
ORDER BY total_libros_publicados DESC;

--8. Encuentra los títulos de libros junto con el nombre de la editorial y muestra solo los libros que contienen la palabra "Psychology" en su título. Ordena el resultado por el título del libro.
SELECT titles.title, publishers.pub_name
FROM titles
RIGHT JOIN publishers ON titles.pub_id = publishers.pub_id
WHERE LOWER(titles.title) LIKE '%Psychology%'
ORDER BY titles.title;

--9. Muestra el nombre de las tiendas junto con el total de ventas en 1992. Incluye todas las tiendas, incluso aquellas que no tuvieron ventas en ese año.
SELECT stores.stor_name, COALESCE(SUM(sales.qty), 0) AS total_ventas_1992
FROM stores
RIGHT JOIN sales ON stores.stor_id = sales.stor_id
WHERE YEAR(sales.ord_date) = 1992
GROUP BY stores.stor_name
ORDER BY stores.stor_name;

--10. Encuentra los títulos de libros junto con el nombre de la editorial y muestra solo los libros que se publicaron en la década de 1980. Ordena el resultado por el título del libro.
SELECT titles.title, publishers.pub_name, titles.pubdate
FROM titles
RIGHT JOIN publishers ON titles.pub_id = publishers.pub_id
WHERE YEAR(titles.pubdate) BETWEEN 1980 AND 1989
ORDER BY titles.title;

--11. Encuentra los nombres de los autores junto con el número total de libros que han escrito. Muestra solo los autores que han escrito más de 5 libros, y ordena el resultado por la cantidad de libros de manera descendente.
SELECT authors.au_id, authors.au_fname, authors.au_lname, COUNT(titles.title_id) AS total_libros
FROM authors
RIGHT JOIN titleauthor ON authors.au_id = titleauthor.au_id
RIGHT JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_fname, authors.au_lname
HAVING COUNT(titles.title_id) > 5
ORDER BY total_libros DESC;

--12. Encuentra los títulos de libros junto con el nombre de la editorial y muestra solo los libros que se publicaron en enero de 1994. Ordena el resultado por el título del libro.
SELECT titles.title, publishers.pub_name, titles.pubdate
FROM titles
RIGHT JOIN publishers ON titles.pub_id = publishers.pub_id
WHERE YEAR(titles.pubdate) = 1994 AND MONTH(titles.pubdate) = 1
ORDER BY titles.title;

--13. Muestra los títulos de libros junto con el total de copias vendidas. Incluye todos los títulos de libros, incluso aquellos que no han sido vendidos.
SELECT titles.title, COALESCE(SUM(sales.qty), 0) AS total_copias_vendidas
FROM sales
RIGHT JOIN titles ON sales.title_id = titles.title_id
GROUP BY titles.title
ORDER BY titles.title;

--14. Encuentra los títulos de libros junto con el número de ventas de cada libro. Muestra solo los libros que han sido vendidos al menos una vez. Ordena el resultado por el número de ventas de manera descendente.
SELECT titles.title, COUNT(sales.title_id) AS numero_ventas
FROM titles
RIGHT JOIN sales ON titles.title_id = sales.title_id
GROUP BY titles.title
HAVING COUNT(sales.title_id) > 0
ORDER BY numero_ventas DESC;

--15. Encuentra los nombres de las tiendas junto con la cantidad total de ventas realizadas en 1994. Muestra solo las tiendas que han tenido ventas en ese año. Ordena el resultado por la cantidad de ventas de manera descendente.
SELECT stores.stor_name, SUM(sales.qty) AS total_ventas_1994
FROM stores
RIGHT JOIN sales ON stores.stor_id = sales.stor_id
WHERE YEAR(sales.ord_date) = 1994
GROUP BY stores.stor_name
HAVING SUM(sales.qty) > 0
ORDER BY total_ventas_1994 DESC;

--16. Encuentra los títulos de libros junto con el nombre de los autores y muestra solo los libros escritos por más de un autor. Ordena el resultado por el título del libro.
SELECT titles.title, authors.au_fname, authors.au_lname
FROM titles
RIGHT JOIN titleauthor ON titles.title_id = titleauthor.title_id
RIGHT JOIN authors ON titleauthor.au_id = authors.au_id
WHERE titles.title_id IN (
    SELECT title_id
    FROM titleauthor
    GROUP BY title_id
    HAVING COUNT(title_id) > 1
)
ORDER BY titles.title;

--17. Encuentra los nombres de las editoriales junto con la cantidad total de libros que han publicado, ordenando el resultado por la cantidad de libros de manera descendente.
SELECT publishers.pub_name, COUNT(titles.title_id) AS total_libros_publicados
FROM publishers
RIGHT JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_name
ORDER BY total_libros_publicados DESC;

--18. Muestra los nombres de los autores junto con la cantidad de libros escritos. Incluye todos los autores, incluso aquellos que no han escrito libros.
SELECT authors.au_fname, authors.au_lname, COALESCE(COUNT(titleauthor.title_id), 0) AS total_libros_escritos
FROM authors
RIGHT JOIN titleauthor ON authors.au_id = titleauthor.au_id
GROUP BY authors.au_fname, authors.au_lname
ORDER BY authors.au_lname, authors.au_fname;

--19. Encuentra los títulos de libros junto con el nombre de la editorial y muestra solo los libros que se publicaron en la década de 1990. Ordena el resultado por el título del libro.
SELECT titles.title, publishers.pub_name, titles.pubdate
FROM titles
RIGHT JOIN publishers ON titles.pub_id = publishers.pub_id
WHERE YEAR(titles.pubdate) BETWEEN 1990 AND 1999
ORDER BY titles.title;

--20. Encuentra los títulos de libros junto con el nombre de los autores y muestra solo los libros que se publicaron antes de 1995. Ordena el resultado por el año de publicación de manera ascendente.
SELECT titles.title, authors.au_fname, authors.au_lname, titles.pubdate
FROM titles
RIGHT JOIN titleauthor ON titles.title_id = titleauthor.title_id
RIGHT JOIN authors ON titleauthor.au_id = authors.au_id
WHERE YEAR(titles.pubdate) < 1995
ORDER BY titles.pubdate ASC;

--21. Encuentra los nombres de los autores junto con la cantidad total de libros que han escrito. Muestra solo los autores que han escrito más de 2 libros y ordena el resultado por la cantidad de libros de manera descendente.
SELECT authors.au_id, authors.au_fname, authors.au_lname, COUNT(titles.title_id) AS total_libros
FROM authors
RIGHT JOIN titleauthor ON authors.au_id = titleauthor.au_id
RIGHT JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_fname, authors.au_lname
HAVING COUNT(titles.title_id) > 2
ORDER BY total_libros DESC;

--22. Muestra los detalles de los trabajos junto con los nombres de los empleados. Incluye todos los trabajos, incluso aquellos que no tienen empleados asignados.
SELECT jobs.job_desc, employee.fname, employee.lname
FROM jobs
RIGHT JOIN employee ON jobs.job_id = employee.job_id
ORDER BY jobs.job_desc, employee.lname, employee.fname;

--23. Encuentra los títulos de libros junto con el número total de ventas de cada libro en 1994. Muestra solo los libros que han sido vendidos al menos una vez en ese año. Ordena el resultado por el número de ventas de manera descendente.
SELECT titles.title, SUM(sales.qty) AS total_ventas_1994
FROM titles
RIGHT JOIN sales ON titles.title_id = sales.title_id
WHERE YEAR(sales.ord_date) = 1994
GROUP BY titles.title
HAVING SUM(sales.qty) > 0
ORDER BY total_ventas_1994 DESC;

--24. Encuentra los nombres de las tiendas junto con la cantidad total de ventas realizadas en 1994. Muestra solo las tiendas que han tenido ventas en ese año. Ordena el resultado por la cantidad de ventas de manera descendente.
SELECT stores.stor_name, SUM(sales.qty) AS total_ventas_1994
FROM stores
RIGHT JOIN sales ON stores.stor_id = sales.stor_id
WHERE YEAR(sales.ord_date) = 1994
GROUP BY stores.stor_name
HAVING SUM(sales.qty) > 0
ORDER BY total_ventas_1994 DESC;

--25. cuentra los nombres de las editoriales junto con la cantidad total de libros que han publicado. Muestra solo las editoriales que han publicado al menos un libro. Ordena el resultado por la cantidad de libros de manera descendente.
SELECT publishers.pub_name, COUNT(titles.title_id) AS total_libros_publicados
FROM publishers
RIGHT JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_name
HAVING COUNT(titles.title_id) > 0
ORDER BY total_libros_publicados DESC;

--Consultas con FULL JOIN
--1. Encuentra los nombres de los autores junto con la cantidad total de libros que han escrito. Muestra todos los autores, incluso aquellos que no han escrito libros, y ordena el resultado por la cantidad de libros de manera descendente.
SELECT authors.au_id, authors.au_fname, authors.au_lname, COALESCE(COUNT(titles.title_id), 0) AS total_libros
FROM authors
FULL JOIN titleauthor ON authors.au_id = titleauthor.au_id
FULL JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_fname, authors.au_lname
ORDER BY total_libros DESC;

--2. Encuentra los títulos de libros junto con la cantidad total de ventas de cada libro. Muestra todos los libros, incluso aquellos que no han sido vendidos, y ordena el resultado por la cantidad de ventas de manera descendente.
SELECT titles.title, COALESCE(SUM(sales.qty), 0) AS total_ventas
FROM titles
FULL JOIN sales ON titles.title_id = sales.title_id
GROUP BY titles.title
ORDER BY total_ventas DESC;

--3. Encuentra los nombres de las tiendas junto con la cantidad total de ventas realizadas en 1993 1994. Muestra todas las tiendas, incluso aquellas que no han tenido ventas en ese año, y ordena el resultado por la cantidad de ventas de manera descendente.
SELECT stores.stor_name, COALESCE(SUM(sales.qty), 0) AS total_ventas_1993
FROM stores
FULL JOIN sales ON stores.stor_id = sales.stor_id
WHERE YEAR(sales.ord_date) = 1993
GROUP BY stores.stor_name
ORDER BY total_ventas_1993 DESC;

--4. Encuentra los nombres de los autores junto con la cantidad total de libros que han escrito. Muestra solo los autores que han escrito más de 2 libros y ordena el resultado por la cantidad de libros de manera descendente.
SELECT authors.au_id, authors.au_fname, authors.au_lname, COALESCE(COUNT(titles.title_id), 0) AS total_libros
FROM authors
FULL JOIN titleauthor ON authors.au_id = titleauthor.au_id
FULL JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_fname, authors.au_lname
HAVING COALESCE(COUNT(titles.title_id), 0) > 2
ORDER BY total_libros DESC;

--5. Encuentra los títulos de libros junto con el nombre de la editorial y muestra solo los libros que contienen la palabra "Computer" en su título, sin importar mayúsculas o minúsculas. Ordena el resultado por el título del libro.
SELECT titles.title, publishers.pub_name
FROM titles
FULL JOIN publishers ON titles.pub_id = publishers.pub_id
WHERE LOWER(titles.title) LIKE '%Computer%'
ORDER BY titles.title;

--6. Muestra los títulos de libros junto con la cantidad total de copias vendidas. Incluye todos los títulos de libros, incluso aquellos que no han sido vendidos.
SELECT titles.title, COALESCE(SUM(sales.qty), 0) AS total_copias_vendidas
FROM titles
FULL JOIN sales ON titles.title_id = sales.title_id
GROUP BY titles.title
ORDER BY titles.title;

--7. Encuentra los títulos de libros junto con la cantidad total de ventas de cada libro en 1994. Muestra todos los libros, incluso aquellos que no han sido vendidos en ese año, y ordena el resultado por el número de ventas de manera descendente.
SELECT titles.title, COALESCE(SUM(sales.qty), 0) AS total_ventas_1994
FROM titles
FULL JOIN sales ON titles.title_id = sales.title_id
WHERE YEAR(sales.ord_date) = 1994
GROUP BY titles.title
ORDER BY total_ventas_1994 DESC;

--8. Encuentra los nombres de las tiendas junto con la cantidad total de ventas realizadas en 1994. Muestra todas las tiendas, incluso aquellas que no han tenido ventas en ese año, y ordena el resultado por el nombre de la tienda de manera ascendente.
SELECT stores.stor_name, COALESCE(SUM(sales.qty), 0) AS total_ventas_1994
FROM stores
FULL JOIN sales ON stores.stor_id = sales.stor_id
WHERE YEAR(sales.ord_date) = 1994
GROUP BY stores.stor_name
ORDER BY stores.stor_name;

--9. Calcula las ventas totales de 1992 para cada tienda y muestra el nombre de la tienda junto con el total de ventas. Incluye todas las tiendas, incluso aquellas que no tuvieron ventas en 1992. Ordena el resultado por el nombre de la tienda de manera ascendente.
SELECT stores.stor_name, COALESCE(SUM(sales.qty), 0) AS total_ventas_1992
FROM stores
FULL JOIN sales ON stores.stor_id = sales.stor_id
WHERE YEAR(sales.ord_date) = 1992
GROUP BY stores.stor_name
ORDER BY stores.stor_name;

--10. Encuentra los nombres de las editoriales junto con la cantidad total de libros que han publicado. Muestra todas las editoriales, incluso aquellas que no han publicado ningún libro, y ordena el resultado por la cantidad de libros de manera descendente.
SELECT publishers.pub_name, COALESCE(COUNT(titles.title_id), 0) AS total_libros_publicados
FROM publishers
FULL JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_name
ORDER BY total_libros_publicados DESC;

--11. Encuentra los títulos de libros junto con el nombre de los autores y muestra solo los libros que se publicaron después de 1990. Ordena el resultado por el año de publicación de manera ascendente.
SELECT titles.title, authors.au_fname, authors.au_lname, titles.pubdate
FROM titles
FULL JOIN titleauthor ON titles.title_id = titleauthor.title_id
FULL JOIN authors ON titleauthor.au_id = authors.au_id
WHERE YEAR(titles.pubdate) > 1990
ORDER BY titles.pubdate ASC;

--12. Encuentra los nombres de los autores junto con la cantidad total de libros que han escrito. Muestra todos los autores, incluso aquellos que no han escrito libros, y ordena el resultado por la cantidad de libros de manera descendente.
SELECT authors.au_id, authors.au_fname, authors.au_lname, COALESCE(COUNT(titles.title_id), 0) AS total_libros
FROM authors
FULL JOIN titleauthor ON authors.au_id = titleauthor.au_id
FULL JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_fname, authors.au_lname
ORDER BY total_libros DESC;

--13. Muestra los títulos de libros junto con el nombre de las editoriales. Incluye todos los títulos de libros, incluso aquellos que no tienen una editorial asociada.
SELECT titles.title, COALESCE(publishers.pub_name, 'Desconocido') AS publisher_name
FROM titles
FULL JOIN publishers ON titles.pub_id = publishers.pub_id
ORDER BY titles.title;

--14. Encuentra los títulos de libros junto con la cantidad total de ventas de cada libro en 1994. Muestra todos los libros, incluso aquellos que no han sido vendidos en ese año, y ordena el resultado por el número de ventas de manera descendente.
SELECT titles.title, COALESCE(SUM(sales.qty), 0) AS total_ventas_1994
FROM titles
FULL JOIN sales ON titles.title_id = sales.title_id
WHERE YEAR(sales.ord_date) = 1994
GROUP BY titles.title
ORDER BY total_ventas_1994 DESC;

--15. Encuentra los nombres de las tiendas junto con la cantidad total de ventas realizadas en 1994. Muestra todas las tiendas, incluso aquellas que no han tenido ventas en ese año, y ordena el resultado por la cantidad de ventas de manera descendente.
SELECT stores.stor_name, COALESCE(SUM(sales.qty), 0) AS total_ventas_1994
FROM stores
FULL JOIN sales ON stores.stor_id = sales.stor_id
WHERE YEAR(sales.ord_date) = 1994
GROUP BY stores.stor_name
ORDER BY total_ventas_1994 DESC;

--16. Encuentra los títulos de libros junto con la cantidad total de ventas de cada libro en 1994. Muestra todos los libros, incluso aquellos que no han sido vendidos en ese año, y ordena el resultado por el título del libro de manera ascendente.
SELECT titles.title, COALESCE(SUM(sales.qty), 0) AS total_ventas_1994
FROM titles
FULL JOIN sales ON titles.title_id = sales.title_id
WHERE YEAR(sales.ord_date) = 1994
GROUP BY titles.title
ORDER BY titles.title;

--17. Encuentra los nombres de las editoriales junto con la cantidad total de libros que han publicado. Muestra todas las editoriales, incluso aquellas que no han publicado ningún libro, y ordena el resultado por la cantidad de libros de manera descendente.
SELECT publishers.pub_name, COALESCE(COUNT(titles.title_id), 0) AS total_libros_publicados
FROM publishers
FULL JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_name
ORDER BY total_libros_publicados DESC;

--18. Encuentra los títulos de libros junto con la fecha de la primera venta de cada libro, excluyendo los libros que no han sido vendidos. Ordena el resultado por el título del libro de manera ascendente.
SELECT titles.title, MIN(sales.ord_date) AS primera_venta
FROM titles
FULL JOIN sales ON titles.title_id = sales.title_id
GROUP BY titles.title
HAVING MIN(sales.ord_date) IS NOT NULL
ORDER BY titles.title;

--19. Encuentrar los nombres de los autores de libros junto con la cantidad total de libros que han escrito. Incluye a todos los autores, incluso aquellos que no han escrito libros. Ordena el resultado por la cantidad de libros de manera descendente.
SELECT authors.au_id, authors.au_fname, authors.au_lname, COALESCE(COUNT(titles.title_id), 0) AS total_libros
FROM authors
FULL JOIN titleauthor ON authors.au_id = titleauthor.au_id
FULL JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_fname, authors.au_lname
ORDER BY total_libros DESC;

--20. Encuentra los títulos de libros junto con el nombre de los autores y muestra solo los libros que se publicaron antes de 2000. Ordena el resultado por el año de publicación de manera ascendente.
SELECT titles.title, authors.au_fname, authors.au_lname, titles.pubdate
FROM titles
FULL JOIN titleauthor ON titles.title_id = titleauthor.title_id
FULL JOIN authors ON titleauthor.au_id = authors.au_id
WHERE YEAR(titles.pubdate) < 2000
ORDER BY titles.pubdate ASC;

--21. Encuentra los nombres de los autores junto con la cantidad total de libros que han escrito. Muestra todos los autores, incluso aquellos que no han escrito libros, y ordena el resultado por la cantidad de libros de manera descendente.
SELECT authors.au_id, authors.au_fname, authors.au_lname, COALESCE(COUNT(titles.title_id), 0) AS total_libros
FROM authors
FULL JOIN titleauthor ON authors.au_id = titleauthor.au_id
FULL JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_fname, authors.au_lname
ORDER BY total_libros DESC;

--22. Encuentra los títulos de libros junto con la cantidad total de ventas de cada libro. Muestra todos los libros, incluso aquellos que no han sido vendidos, y ordena el resultado por la cantidad de ventas de manera descendente.
SELECT titles.title, COALESCE(SUM(sales.qty), 0) AS total_ventas
FROM titles
FULL JOIN sales ON titles.title_id = sales.title_id
GROUP BY titles.title
ORDER BY total_ventas DESC;

--23. Encuentra los nombres de las tiendas junto con la cantidad total de ventas realizadas en 1994. Muestra todas las tiendas, incluso aquellas que no han tenido ventas en ese año, y ordena el resultado por la cantidad de ventas de manera descendente.
SELECT stores.stor_name, COALESCE(SUM(sales.qty), 0) AS total_ventas_1994
FROM stores
FULL JOIN sales ON stores.stor_id = sales.stor_id
WHERE YEAR(sales.ord_date) = 1994
GROUP BY stores.stor_name
ORDER BY total_ventas_1994 DESC;

--24. Encuentra los títulos de libros junto con la cantidad total de ventas de cada libro en 1994. Muestra todos los libros, incluso aquellos que no han sido vendidos en ese año, y ordena el resultado por el número de ventas de manera descendente.
SELECT titles.title, COALESCE(SUM(sales.qty), 0) AS total_ventas_1993
FROM titles
FULL JOIN sales ON titles.title_id = sales.title_id
WHERE YEAR(sales.ord_date) = 1993
GROUP BY titles.title
ORDER BY total_ventas_1993 DESC;

--25. Encuentra los títulos de libros junto con la fecha de la primera venta de cada libro, excluyendo los libros que no han sido vendidos. Ordena el resultado por el título del libro de manera ascendente.
SELECT titles.title, MIN(sales.ord_date) AS primera_venta
FROM titles
FULL JOIN sales ON titles.title_id = sales.title_id
GROUP BY titles.title
HAVING MIN(sales.ord_date) IS NOT NULL
ORDER BY titles.title;