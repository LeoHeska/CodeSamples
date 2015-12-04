select * from midas.mlx_pdf_queue 
where program_name = 'MicroStation'
and doc_elid in 
(select b.elid
from ustn_drawing a, wm_elements b, wm_files c
where a.infos = b.infos and b.elid = c.elid
and pri_design_control = 'UCP'
and program_name = 'Acrobat'
minus
select b.elid
from ustn_drawing a, wm_elements b, wm_files c
where a.infos = b.infos and b.elid = c.elid
and pri_design_control = 'UCP'
and program_name = 'Acrobat_micro')
and time_of_plot > '15-jan-04';

-- The below is twice as fast as the above.
-- Note that if run while the import process
-- is still running, it will occasionally
-- display a record corresponding to a document
-- which is only partially imported.
select * from midas.mlx_pdf_queue 
where program_name = 'MicroStation'
and doc_elid in 
(
select b.elid
from ustn_drawing a, wm_elements b, wm_files c
where a.infos = b.infos and b.elid = c.elid
and pri_design_control = 'UCP'
and program_name like 'Acrobat%'
having count(*) < 2
group by b.elid
)
and time_of_plot > '19-jan-04'


select * from midas.mlx_pdf_queue 
where program_name = 'MicroStation'
-- and doc_elid in 
-- (select b.elid
-- from ustn_drawing a, wm_elements b, wm_files c
-- where a.infos = b.infos and b.elid = c.elid
-- and pri_design_control = 'UCP'
-- and program_name = 'Acrobat'
-- minus
-- select b.elid
-- from ustn_drawing a, wm_elements b, wm_files c
-- where a.infos = b.infos and b.elid = c.elid
-- and pri_design_control = 'UCP'
-- and program_name = 'Acrobat_micro')
and time_of_plot > '13-jan-05';
