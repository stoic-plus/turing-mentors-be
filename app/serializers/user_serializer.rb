class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :cohort, :program, :current_job, :background, :mentor, :location
end