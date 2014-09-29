shared_context 'subject class' do
  let(:model) { subject.class }
  let(:factory) { model.to_s.underscore.to_sym }
end
