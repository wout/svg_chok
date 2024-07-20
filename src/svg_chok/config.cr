struct SvgChok::Config
  include YAML::Serializable

  getter dir : String
  getter port : Int32 = 4141
end
