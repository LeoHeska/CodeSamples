insert into mlx_plot_stg(document_no, doc_class_name, doc_state, mlx_printer_name, 
plot_server, priority, program_name, program_revision, requested_by, return_name, 
revision, sheet_no, vax_filename, file_id, doc_infos, doc_elid)
select id_no, 'USTN_DRAWING', state, 'nullprt', 'P-P-UAU', '2', program_name, 
program_revision, 'batch', c.file_name, a.rev, a.sheet_no, 
c.file_name, c.fid, a.infos, b.elid
from ustn_drawing a, wm_elements b, wm_files c
where a.infos = b.infos and b.elid = c.elid
and a.infos in
(select infos
from ustn_drawing where pri_design_control = 'UAU'
minus
select distinct b.infos
from ustn_drawing a, wm_elements b, wm_ele_links c, wm_elements d, ustn_master e
where a.infos = b.infos
and b.elid = c.parent_element
and c.child_element = d.elid
and d.infos = e.infos
and a.pri_design_control = 'UAU');