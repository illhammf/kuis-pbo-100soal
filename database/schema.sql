-- Jalankan file ini pada database PostgreSQL yang sudah dibuat, misalnya kuis_pbo.
CREATE TABLE IF NOT EXISTS questions (
    id SERIAL PRIMARY KEY,
    meeting_no SMALLINT NOT NULL CHECK (meeting_no BETWEEN 1 AND 5),
    question_text TEXT NOT NULL,
    option_a TEXT NOT NULL,
    option_b TEXT NOT NULL,
    option_c TEXT NOT NULL,
    option_d TEXT NOT NULL,
    correct_option CHAR(1) NOT NULL CHECK (correct_option IN ('A','B','C','D')),
    active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS quiz_attempts (
    id BIGSERIAL PRIMARY KEY,
    student_name VARCHAR(150) NOT NULL,
    student_nim VARCHAR(40) NOT NULL,
    started_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    finished_at TIMESTAMPTZ,
    total_questions SMALLINT NOT NULL DEFAULT 10,
    correct_count SMALLINT NOT NULL DEFAULT 0,
    wrong_count SMALLINT NOT NULL DEFAULT 0,
    unanswered_count SMALLINT NOT NULL DEFAULT 0,
    score NUMERIC(5,2) NOT NULL DEFAULT 0
);

CREATE TABLE IF NOT EXISTS attempt_answers (
    id BIGSERIAL PRIMARY KEY,
    attempt_id BIGINT NOT NULL REFERENCES quiz_attempts(id) ON DELETE CASCADE,
    question_id INTEGER NOT NULL REFERENCES questions(id),
    question_order SMALLINT NOT NULL,
    selected_option CHAR(1),
    is_correct BOOLEAN NOT NULL DEFAULT FALSE,
    timed_out BOOLEAN NOT NULL DEFAULT FALSE,
    answered_at TIMESTAMPTZ,
    UNIQUE (attempt_id, question_order),
    UNIQUE (attempt_id, question_id)
);

CREATE INDEX IF NOT EXISTS idx_attempts_nim ON quiz_attempts(student_nim);
CREATE INDEX IF NOT EXISTS idx_attempts_started_at ON quiz_attempts(started_at);
