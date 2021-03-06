class ExpensesController < ApplicationController
  before_action :set_groups, only: %i[new edit]
  before_action :set_expense, only: %i[edit update destroy show]

  def all_expenses
    @expenses = current_user.expenses.order(created_at: :desc)
    @total = Expense.sum_expenses(@expenses)
  end

  def all_external_expenses
    @expenses = Expense.ungrouped.created_by(current_user).order(created_at: :desc)
    @total = Expense.sum_expenses(@expenses)
  end

  def show
    @groups = @expense.groups
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = current_user.expenses.build(expense_params)
    if @expense.save
      flash[:notice] = 'Expense was created successfully'
      redirect_to all_expenses_path
    else
      set_groups
      render 'new'
    end
  end

  def edit; end

  def update
    if @expense.update(expense_params)
      flash[:notice] = 'Expense was successfully updated'
      redirect_to all_expenses_path
    else
      render 'edit'
    end
  end

  def destroy
    @expense.destroy
    flash[:alert] = 'Expense deleted'
    redirect_to all_expenses_path
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount, group_ids: [])
  end

  def set_groups
    @groups = current_user.groups
  end

  def set_expense
    @expense = Expense.find(params[:id])
  end
end
