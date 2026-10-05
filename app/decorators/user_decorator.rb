class UserDecorator < Draper::Decorator
  delegate_all

  def full_name # objectはdecoratorがラップしている元のオブジェクトを指す
    "#{object.last_name} #{object.first_name}"
  end
end
