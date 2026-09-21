-- Allow deleting classes/courses/programs even when related records exist
-- by cascading the delete to dependent rows instead of blocking it.

-- CLASSES: enrollments and class_transfers block deletion
ALTER TABLE enrollments DROP CONSTRAINT IF EXISTS enrollments_class_id_fkey;
ALTER TABLE enrollments ADD CONSTRAINT enrollments_class_id_fkey
  FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE CASCADE;

ALTER TABLE class_transfers DROP CONSTRAINT IF EXISTS class_transfers_from_class_id_fkey;
ALTER TABLE class_transfers ADD CONSTRAINT class_transfers_from_class_id_fkey
  FOREIGN KEY (from_class_id) REFERENCES classes(id) ON DELETE SET NULL;

ALTER TABLE class_transfers DROP CONSTRAINT IF EXISTS class_transfers_to_class_id_fkey;
ALTER TABLE class_transfers ADD CONSTRAINT class_transfers_to_class_id_fkey
  FOREIGN KEY (to_class_id) REFERENCES classes(id) ON DELETE SET NULL;

-- COURSES: enrollments, payment_plans, certificates block deletion
ALTER TABLE enrollments DROP CONSTRAINT IF EXISTS enrollments_course_id_fkey;
ALTER TABLE enrollments ADD CONSTRAINT enrollments_course_id_fkey
  FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE;

ALTER TABLE payment_plans DROP CONSTRAINT IF EXISTS payment_plans_course_id_fkey;
ALTER TABLE payment_plans ADD CONSTRAINT payment_plans_course_id_fkey
  FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE;

ALTER TABLE certificates DROP CONSTRAINT IF EXISTS certificates_course_id_fkey;
ALTER TABLE certificates ADD CONSTRAINT certificates_course_id_fkey
  FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE SET NULL;

-- PROGRAMS: courses block deletion (modules already cascade)
ALTER TABLE courses DROP CONSTRAINT IF EXISTS courses_program_id_fkey;
ALTER TABLE courses ADD CONSTRAINT courses_program_id_fkey
  FOREIGN KEY (program_id) REFERENCES programs(id) ON DELETE CASCADE;
