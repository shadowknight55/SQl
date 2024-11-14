SELECT
    p.title AS project_title,
	p.description,
	group_concat(s.name) AS skills_used
FROM projects p
INNER JOIN project_skills ps ON p.project_id = ps.project_id
INNER JOIN skills s on ps.skill_id = s.skill_id
GROUP BY p.project_id
order by p.title;
