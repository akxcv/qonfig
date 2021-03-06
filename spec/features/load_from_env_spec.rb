# frozen_string_literal: true

describe 'Load from ENV' do
  specify 'defines config object by ENV data' do
    ENV['QONFIG_SPEC_TRUE_VALUE_V1'] = 'true'
    ENV['QONFIG_SPEC_TRUE_VALUE_V2'] = 't'
    ENV['QONFIG_SPEC_TRUE_VALUE_V3'] = 'TRUE'
    ENV['QONFIG_SPEC_TRUE_VALUE_V4'] = 'T'

    ENV['QONFIG_SPEC_FALSE_VALUE_V1'] = 'false'
    ENV['QONFIG_SPEC_FALSE_VALUE_V2'] = 'f'
    ENV['QONFIG_SPEC_FALSE_VALUE_V3'] = 'FALSE'
    ENV['QONFIG_SPEC_FALSE_VALUE_V4'] = 'F'

    ENV['QONFIG_SPEC_INTEGER_VALUE'] = '1'
    ENV['QONFIG_SPEC_FLOAT_VALUE']   = '1.55'

    ENV['QONFIG_SPEC_ARRAY_VALUE_V1'] = 'true, t, TRUE ,T , false,f,FALSE,f'
    ENV['QONFIG_SPEC_ARRAY_VALUE_V2'] = '1, 2, 3.4, 5.6 ,0.0'
    ENV['QONFIG_SPEC_ARRAY_VALUE_V3'] = 'Qonfig,Settings,DSL'

    ENV['QONFIG_SPEC_QUOTED_STRING_VALUE_V1'] = '"test, please"'
    ENV['QONFIG_SPEC_QUOTED_STRING_VALUE_V2'] = "'please, test'"

    ENV['QONFIG_SPEC_GENERIC_VALUE_V1'] = '1,66'
    ENV['QONFIG_SPEC_GENERIC_VALUE_V2'] = '123.456trueTRUEfalseFALSEtTfF.123'

    ENV['NON_QONFIG_SPEC_GENERIC_VALUE'] = 'test'

    class EnvConfig < Qonfig::DataSet
      setting :default do
        load_from_env
      end

      setting :converted do
        load_from_env convert_values: true
      end

      setting :prefixed do
        load_from_env prefix: 'QONFIG_SPEC'
      end

      setting :prefix_regexp do
        load_from_env prefix: /\Aqonfig.*\z/i
      end

      setting :trimmed_prefix do
        load_from_env prefix: 'QONFIG_SPEC_', trim_prefix: true
      end

      setting :all_in do
        load_from_env convert_values: true, prefix: 'QONFIG_SPEC_', trim_prefix: true
      end
    end

    config = EnvConfig.new

    # rubocop:disable Metrics/LineLength
    expect(config[:default][:QONFIG_SPEC_TRUE_VALUE_V1]).to          eq('true')
    expect(config[:default][:QONFIG_SPEC_TRUE_VALUE_V2]).to          eq('t')
    expect(config[:default][:QONFIG_SPEC_TRUE_VALUE_V3]).to          eq('TRUE')
    expect(config[:default][:QONFIG_SPEC_TRUE_VALUE_V4]).to          eq('T')
    expect(config[:default][:QONFIG_SPEC_FALSE_VALUE_V1]).to         eq('false')
    expect(config[:default][:QONFIG_SPEC_FALSE_VALUE_V2]).to         eq('f')
    expect(config[:default][:QONFIG_SPEC_FALSE_VALUE_V3]).to         eq('FALSE')
    expect(config[:default][:QONFIG_SPEC_FALSE_VALUE_V4]).to         eq('F')
    expect(config[:default][:QONFIG_SPEC_INTEGER_VALUE]).to          eq('1')
    expect(config[:default][:QONFIG_SPEC_FLOAT_VALUE]).to            eq('1.55')
    expect(config[:default][:QONFIG_SPEC_GENERIC_VALUE_V1]).to       eq('1,66')
    expect(config[:default][:QONFIG_SPEC_GENERIC_VALUE_V2]).to       eq('123.456trueTRUEfalseFALSEtTfF.123')
    expect(config[:default][:QONFIG_SPEC_ARRAY_VALUE_V1]).to         eq('true, t, TRUE ,T , false,f,FALSE,f')
    expect(config[:default][:QONFIG_SPEC_ARRAY_VALUE_V2]).to         eq('1, 2, 3.4, 5.6 ,0.0')
    expect(config[:default][:QONFIG_SPEC_ARRAY_VALUE_V3]).to         eq('Qonfig,Settings,DSL')
    expect(config[:default][:QONFIG_SPEC_QUOTED_STRING_VALUE_V1]).to eq('"test, please"')
    expect(config[:default][:QONFIG_SPEC_QUOTED_STRING_VALUE_V2]).to eq("'please, test'")
    expect(config[:default][:NON_QONFIG_SPEC_GENERIC_VALUE]).to      eq('test')

    expect(config[:converted][:QONFIG_SPEC_TRUE_VALUE_V1]).to          eq(true)
    expect(config[:converted][:QONFIG_SPEC_TRUE_VALUE_V2]).to          eq(true)
    expect(config[:converted][:QONFIG_SPEC_TRUE_VALUE_V3]).to          eq(true)
    expect(config[:converted][:QONFIG_SPEC_TRUE_VALUE_V4]).to          eq(true)
    expect(config[:converted][:QONFIG_SPEC_FALSE_VALUE_V1]).to         eq(false)
    expect(config[:converted][:QONFIG_SPEC_FALSE_VALUE_V2]).to         eq(false)
    expect(config[:converted][:QONFIG_SPEC_FALSE_VALUE_V3]).to         eq(false)
    expect(config[:converted][:QONFIG_SPEC_FALSE_VALUE_V4]).to         eq(false)
    expect(config[:converted][:QONFIG_SPEC_INTEGER_VALUE]).to          eq(1)
    expect(config[:converted][:QONFIG_SPEC_FLOAT_VALUE]).to            eq(1.55)
    expect(config[:converted][:QONFIG_SPEC_GENERIC_VALUE_V1]).to       eq([1, 66])
    expect(config[:converted][:QONFIG_SPEC_GENERIC_VALUE_V2]).to       eq('123.456trueTRUEfalseFALSEtTfF.123')
    expect(config[:converted][:QONFIG_SPEC_ARRAY_VALUE_V1]).to         eq([true, true, true, true, false, false, false, false])
    expect(config[:converted][:QONFIG_SPEC_ARRAY_VALUE_V2]).to         eq([1, 2, 3.4, 5.6, 0.0])
    expect(config[:converted][:QONFIG_SPEC_ARRAY_VALUE_V3]).to         eq(%w[Qonfig Settings DSL])
    expect(config[:converted][:QONFIG_SPEC_QUOTED_STRING_VALUE_V1]).to eq('test, please')
    expect(config[:converted][:QONFIG_SPEC_QUOTED_STRING_VALUE_V2]).to eq('please, test')
    expect(config[:converted][:NON_QONFIG_SPEC_GENERIC_VALUE]).to      eq('test')

    expect(config[:prefixed][:QONFIG_SPEC_TRUE_VALUE_V1]).to          eq('true')
    expect(config[:prefixed][:QONFIG_SPEC_TRUE_VALUE_V2]).to          eq('t')
    expect(config[:prefixed][:QONFIG_SPEC_TRUE_VALUE_V3]).to          eq('TRUE')
    expect(config[:prefixed][:QONFIG_SPEC_TRUE_VALUE_V4]).to          eq('T')
    expect(config[:prefixed][:QONFIG_SPEC_FALSE_VALUE_V1]).to         eq('false')
    expect(config[:prefixed][:QONFIG_SPEC_FALSE_VALUE_V2]).to         eq('f')
    expect(config[:prefixed][:QONFIG_SPEC_FALSE_VALUE_V3]).to         eq('FALSE')
    expect(config[:prefixed][:QONFIG_SPEC_FALSE_VALUE_V4]).to         eq('F')
    expect(config[:prefixed][:QONFIG_SPEC_INTEGER_VALUE]).to          eq('1')
    expect(config[:prefixed][:QONFIG_SPEC_FLOAT_VALUE]).to            eq('1.55')
    expect(config[:prefixed][:QONFIG_SPEC_GENERIC_VALUE_V1]).to       eq('1,66')
    expect(config[:prefixed][:QONFIG_SPEC_GENERIC_VALUE_V2]).to       eq('123.456trueTRUEfalseFALSEtTfF.123')
    expect(config[:prefixed][:QONFIG_SPEC_ARRAY_VALUE_V1]).to         eq('true, t, TRUE ,T , false,f,FALSE,f')
    expect(config[:prefixed][:QONFIG_SPEC_ARRAY_VALUE_V2]).to         eq('1, 2, 3.4, 5.6 ,0.0')
    expect(config[:prefixed][:QONFIG_SPEC_ARRAY_VALUE_V3]).to         eq('Qonfig,Settings,DSL')
    expect(config[:prefixed][:QONFIG_SPEC_QUOTED_STRING_VALUE_V1]).to eq('"test, please"')
    expect(config[:prefixed][:QONFIG_SPEC_QUOTED_STRING_VALUE_V2]).to eq("'please, test'")
    expect { config[:prefixed][:NON_QONFIG_SPEC_GENERIC_VALUE] }.to raise_error(Qonfig::UnknownSettingError)

    expect(config[:prefix_regexp][:QONFIG_SPEC_TRUE_VALUE_V1]).to          eq('true')
    expect(config[:prefix_regexp][:QONFIG_SPEC_TRUE_VALUE_V2]).to          eq('t')
    expect(config[:prefix_regexp][:QONFIG_SPEC_TRUE_VALUE_V3]).to          eq('TRUE')
    expect(config[:prefix_regexp][:QONFIG_SPEC_TRUE_VALUE_V4]).to          eq('T')
    expect(config[:prefix_regexp][:QONFIG_SPEC_FALSE_VALUE_V1]).to         eq('false')
    expect(config[:prefix_regexp][:QONFIG_SPEC_FALSE_VALUE_V2]).to         eq('f')
    expect(config[:prefix_regexp][:QONFIG_SPEC_FALSE_VALUE_V3]).to         eq('FALSE')
    expect(config[:prefix_regexp][:QONFIG_SPEC_FALSE_VALUE_V4]).to         eq('F')
    expect(config[:prefix_regexp][:QONFIG_SPEC_INTEGER_VALUE]).to          eq('1')
    expect(config[:prefix_regexp][:QONFIG_SPEC_FLOAT_VALUE]).to            eq('1.55')
    expect(config[:prefix_regexp][:QONFIG_SPEC_GENERIC_VALUE_V1]).to       eq('1,66')
    expect(config[:prefix_regexp][:QONFIG_SPEC_GENERIC_VALUE_V2]).to       eq('123.456trueTRUEfalseFALSEtTfF.123')
    expect(config[:prefix_regexp][:QONFIG_SPEC_ARRAY_VALUE_V1]).to         eq('true, t, TRUE ,T , false,f,FALSE,f')
    expect(config[:prefix_regexp][:QONFIG_SPEC_ARRAY_VALUE_V2]).to         eq('1, 2, 3.4, 5.6 ,0.0')
    expect(config[:prefix_regexp][:QONFIG_SPEC_ARRAY_VALUE_V3]).to         eq('Qonfig,Settings,DSL')
    expect(config[:prefix_regexp][:QONFIG_SPEC_QUOTED_STRING_VALUE_V1]).to eq('"test, please"')
    expect(config[:prefix_regexp][:QONFIG_SPEC_QUOTED_STRING_VALUE_V2]).to eq("'please, test'")
    expect { config[:prefix_regexp][:NON_QONFIG_SPEC_GENERIC_VALUE] }.to raise_error(Qonfig::UnknownSettingError)

    expect(config[:trimmed_prefix][:TRUE_VALUE_V1]).to          eq('true')
    expect(config[:trimmed_prefix][:TRUE_VALUE_V2]).to          eq('t')
    expect(config[:trimmed_prefix][:TRUE_VALUE_V3]).to          eq('TRUE')
    expect(config[:trimmed_prefix][:TRUE_VALUE_V4]).to          eq('T')
    expect(config[:trimmed_prefix][:FALSE_VALUE_V1]).to         eq('false')
    expect(config[:trimmed_prefix][:FALSE_VALUE_V2]).to         eq('f')
    expect(config[:trimmed_prefix][:FALSE_VALUE_V3]).to         eq('FALSE')
    expect(config[:trimmed_prefix][:FALSE_VALUE_V4]).to         eq('F')
    expect(config[:trimmed_prefix][:INTEGER_VALUE]).to          eq('1')
    expect(config[:trimmed_prefix][:FLOAT_VALUE]).to            eq('1.55')
    expect(config[:trimmed_prefix][:GENERIC_VALUE_V1]).to       eq('1,66')
    expect(config[:trimmed_prefix][:GENERIC_VALUE_V2]).to       eq('123.456trueTRUEfalseFALSEtTfF.123')
    expect(config[:trimmed_prefix][:ARRAY_VALUE_V1]).to         eq('true, t, TRUE ,T , false,f,FALSE,f')
    expect(config[:trimmed_prefix][:ARRAY_VALUE_V2]).to         eq('1, 2, 3.4, 5.6 ,0.0')
    expect(config[:trimmed_prefix][:ARRAY_VALUE_V3]).to         eq('Qonfig,Settings,DSL')
    expect(config[:trimmed_prefix][:QUOTED_STRING_VALUE_V1]).to eq('"test, please"')
    expect(config[:trimmed_prefix][:QUOTED_STRING_VALUE_V2]).to eq("'please, test'")
    expect { config[:trimmed_prefix][:NON_QONFIG_SPEC_GENERIC_VALUE] }.to raise_error(Qonfig::UnknownSettingError)

    expect(config[:all_in][:TRUE_VALUE_V1]).to          eq(true)
    expect(config[:all_in][:TRUE_VALUE_V2]).to          eq(true)
    expect(config[:all_in][:TRUE_VALUE_V3]).to          eq(true)
    expect(config[:all_in][:TRUE_VALUE_V4]).to          eq(true)
    expect(config[:all_in][:FALSE_VALUE_V1]).to         eq(false)
    expect(config[:all_in][:FALSE_VALUE_V2]).to         eq(false)
    expect(config[:all_in][:FALSE_VALUE_V3]).to         eq(false)
    expect(config[:all_in][:FALSE_VALUE_V4]).to         eq(false)
    expect(config[:all_in][:INTEGER_VALUE]).to          eq(1)
    expect(config[:all_in][:FLOAT_VALUE]).to            eq(1.55)
    expect(config[:all_in][:GENERIC_VALUE_V1]).to       eq([1, 66])
    expect(config[:all_in][:GENERIC_VALUE_V2]).to       eq('123.456trueTRUEfalseFALSEtTfF.123')
    expect(config[:all_in][:ARRAY_VALUE_V1]).to         eq([true, true, true, true, false, false, false, false])
    expect(config[:all_in][:ARRAY_VALUE_V2]).to         eq([1, 2, 3.4, 5.6, 0.0])
    expect(config[:all_in][:ARRAY_VALUE_V3]).to         eq(%w[Qonfig Settings DSL])
    expect(config[:all_in][:QUOTED_STRING_VALUE_V1]).to eq('test, please')
    expect(config[:all_in][:QUOTED_STRING_VALUE_V2]).to eq('please, test')
    expect { config[:all_in][:NON_QONFIG_SPEC_GENERIC_VALUE] }.to raise_error(Qonfig::UnknownSettingError)
    # rubocop:enable Metrics/LineLength
  end

  specify 'incorrect definition' do
    incorrect_convert_value_option_values = [
      123, '123', 'true', 't', 'false', 'f', Object.new, 123.5, Class.new
    ]

    incorrect_prefix_option_values = [
      123, Object.new, 123.5, true, false, Class.new
    ]

    incorrect_trim_prefix_option_values = [
      123, '123', 'true', 't', 'false', 'f', Object.new, 123.5, Class.new
    ]

    correct_convert_value_option_values = [true, false]
    correct_prefix_option_values = [nil, 'qonfig', /\Aqonfig.*\z/i]
    correct_trim_prefix_option_values = [true, false]

    incorrect_convert_value_option_values.each do |incorrect_option|
      expect do
        Class.new(Qonfig::DataSet) do
          load_from_env convert_values: incorrect_option
        end
      end.to raise_error(Qonfig::ArgumentError)
    end

    incorrect_prefix_option_values.each do |incorrect_option|
      expect do
        Class.new(Qonfig::DataSet) do
          load_from_env prefix: incorrect_option
        end
      end.to raise_error(Qonfig::ArgumentError)
    end

    incorrect_trim_prefix_option_values.each do |incorrect_option|
      expect do
        Class.new(Qonfig::DataSet) do
          load_from_env trim_prefix: incorrect_option
        end
      end.to raise_error(Qonfig::ArgumentError)
    end

    correct_convert_value_option_values.each do |correct_option|
      expect do
        Class.new(Qonfig::DataSet) do
          load_from_env convert_values: correct_option
        end
      end.not_to raise_error
    end

    correct_prefix_option_values.each do |correct_option|
      expect do
        Class.new(Qonfig::DataSet) do
          load_from_env prefix: correct_option
        end
      end.not_to raise_error
    end

    correct_trim_prefix_option_values.each do |correct_option|
      expect do
        Class.new(Qonfig::DataSet) do
          load_from_env trim_prefix: correct_option
        end
      end.not_to raise_error
    end
  end
end
